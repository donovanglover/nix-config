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
#ifndef _XEVENTBIND_HANDLER_H
#define _XEVENTBIND_HANDLER_H

#include "xeb_event_types.h"

typedef int xeb_callback_id;
/**
 * @param event An event that this function was called for
 * @param data A pointer to, optional, user defined input for the callback function
 * @return 0 on success, anything else for error */
typedef int(*xeb_callback)(xeb_event_type event, void* data);

/**
 * \brief Starts the event loop and blocks the thread until xeb_stop is called
 * @return 0 on sucess, -1 on error
 */
int xeb_loop(void);

void xeb_add_callback(xeb_event_type event, xeb_callback func, void* data);

#endif
