/*
 * SimpleLock.cpp
 *
 *  Created on: 2013.10.25
 *      Author: cjfeii@126.com
 */

#include "SimpleLock.h"

SimpleLock::SimpleLock()
{
	m_lock = FREE;
}

SimpleLock::~SimpleLock()
{
}

void SimpleLock::lock()
{
	struct timespec ts = { 0, 10000 };
    do
    {
		while (m_lock != FREE)
		{
			asm volatile("" : : : "memory");
			 nanosleep(&ts, NULL);
		}
    } while (!__sync_bool_compare_and_swap(&m_lock,FREE,LOCKED));
}

bool SimpleLock::tryLock()
{
	bool out;
	out = __sync_bool_compare_and_swap(&m_lock,FREE,LOCKED);
	return out;
}

void SimpleLock::unlock()
{
	asm volatile("" : : : "memory");
	m_lock = FREE;
}

