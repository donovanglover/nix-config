/*
 * The MIT License (MIT)
 *
 * Copyright (c) 2016 Olaf Tomalka
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */
#include <assert.h>
#include <X11/Xlib.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "xeb_handler.h"

struct callback_data {
    xeb_callback func;
    void *data;
    xeb_event_type event;
};

struct dimensions {
    int width, height;
};

static struct callback_data *callbacks = NULL;
static int callbacks_count = 0;
static int callbacks_capacity = 0;

static void ensure_enough_callback_space(void) {
    if (callbacks_count == 0)
        return;
    if (callbacks_capacity == 0) {
        callbacks = malloc(callbacks_count * sizeof(struct callback_data));
        callbacks_capacity = callbacks_count;
    } else if (callbacks_count > callbacks_capacity) {
        int new_size = callbacks_capacity;
        while (new_size < callbacks_count)
            new_size *= 2;
        callbacks_capacity = new_size;
        struct callback_dat *new_call = realloc(
                callbacks,
                callbacks_capacity * sizeof(struct callback_data));
        if (new_call == NULL) {
            fprintf(stderr, "Failed to realloc callback_data array\n");
            exit(EXIT_FAILURE);
        }
    }
}

void xeb_add_callback(xeb_event_type event, xeb_callback func, void* data) {
    assert(func != NULL);

    callbacks_count++;
    ensure_enough_callback_space();

    struct callback_data *row = &callbacks[callbacks_count - 1];
    row->event = event;
    row->func = func;
    row->data = data;
}

static void call_callbacks(xeb_event_type event) {
    for (int i = 0; i < callbacks_count; i++) {
        struct callback_data callback = callbacks[i];
        if (callback.event == event) {
           callback.func(event, callback.data);
        }
    }
}

int xeb_loop(void) {
    Display *display = XOpenDisplay(NULL);
    if (!display) {
        fprintf(stderr, "Failed to open display\n");
        return -1;
    }

    int screen_count = ScreenCount(display);
    Window roots[screen_count];
    struct dimensions dimens[screen_count];

    for (int i = 0; i < screen_count; i++) {
        roots[i] = RootWindow(display, i);

        XWindowAttributes attrs;
        Status status = XGetWindowAttributes(display, roots[i], &attrs);
        if (!status) {
            fprintf(stderr, "Failed to get root window attributes for screen: %d\n", i);
            return -1;
        }
        dimens[i].width = attrs.width;
        dimens[i].height = attrs.height;

        XSelectInput(display, roots[i], StructureNotifyMask);
    }

    for (;;) {
        XEvent e;
        XNextEvent(display, &e);
        if (e.type == ConfigureNotify) {
            XConfigureEvent xce = e.xconfigure;
            for (int i = 0; i < screen_count; i++) {
                if (xce.window == roots[i]) {
                    if (xce.width != dimens[i].width || xce.height != dimens[i].height) {
                        dimens[i].width = xce.width;
                        dimens[i].height = xce.height;
                        call_callbacks(ResolutionChange);
                    }
                    break;
                }
            }
        }
    }
}
