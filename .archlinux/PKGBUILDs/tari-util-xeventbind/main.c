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
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <assert.h>

#include "xeb_event_types.h"
#include "xeb_handler.h"

struct arguments {
    xeb_event_type event_type;
    char *script_path;
};

struct event_map {
    char *str;
    xeb_event_type event;
};

static struct event_map mapping[] = {
    {"resolution", ResolutionChange}
};

void print_usage(char *path) {
    fprintf(stderr, "Usage: %s event_type script_path\n", path);
    fprintf(stderr, "Event types:\n");
    size_t mapping_size = sizeof(mapping) / sizeof(mapping[0]);
    for (int i = 0; i < mapping_size; i++) {
        fprintf(stderr, "\t%s\n", mapping[i].str);
    }
    exit(EXIT_FAILURE);
}

void parse_args(int argc, char** argv, struct arguments *args) {
    if (argc != 3)
        print_usage(argv[0]);

    size_t mapping_size = sizeof(mapping) / sizeof(mapping[0]);
    int found = 0;
    for (int i = 0; i < mapping_size; i++) {
        if (strcmp(argv[1], mapping[i].str) == 0) {
            found = 1;
            args->event_type = mapping[i].event;
            break;
        }
    }
    if (!found)
        print_usage(argv[0]);

    args->script_path = argv[2];
}

int handle_callback(xeb_event_type event, void *data) {
    assert(data);
    struct arguments *args = data;
    assert(args->event_type == event);

    pid_t pid = fork();
    int err;
    switch (pid) {
        case -1:
            perror("Failed to fork\n");
            exit(EXIT_FAILURE);
            break;
        case 0: // Child
            err = execlp(args->script_path, NULL);
            if (err == -1) {
                perror("Failed to open callback script\n");
                exit(EXIT_FAILURE);
            }
            break;
    }
}

int main(int argc, char **argv) {
    struct arguments args;
    int err;

    parse_args(argc, argv, &args);

    xeb_add_callback(args.event_type, handle_callback, &args);

    return xeb_loop() ? EXIT_FAILURE : EXIT_SUCCESS;
}
