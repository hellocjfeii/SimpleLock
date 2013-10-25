/*
 * SimpleLock.h 
 *
 *  Created on: 2013.10.25
 *      Author: cjfeii@126.com
 */

#ifndef SIMPLELOCK_H__
#define SIMPLELOCK_H_
#include <time.h>

using namespace std;

// A simple exclusive lock.
class SimpleLock {
public:
	SimpleLock();
	~SimpleLock();

public:
	void lock();
	bool tryLock();
	void unlock();

private:
	 enum { FREE = 0, LOCKED = 1 };
	 volatile unsigned char m_lock;
};

// A simple auto exclusive lock.
class SimpleAutoLock
{
private:
	SimpleLock *m_pLock;
public:
	SimpleAutoLock(SimpleLock* pLocker)
	{
		m_pLock = pLocker;
		m_pLock->lock();
	}
	~SimpleAutoLock()
	{
		m_pLock->unlock();
	}
};

#endif /* SIMPLELOCK_H_ */
