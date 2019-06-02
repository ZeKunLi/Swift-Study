/*
 * ipinput.h
 *
 *  Created on: 
 *     
 */
#include <stdio.h>
#include <string.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <sys/socket.h>
#include <errno.h>
#include <stdlib.h>
#include <arpa/inet.h>
#include <pthread.h>

#import "avformat.h"
//#import "CmsMainViewController.h"

#ifndef IPINPUT_H_
#define IPINPUT_H_


typedef struct _NetBufferManager {
    
    pthread_mutex_t locker;
	pthread_cond_t cond;
    
	uint8_t * net_buffer_original_ptr;
	int net_buf_size;
	int write_ptr;
	int read_ptr;
    
} NetBufferManager;

//维护缓冲区的方法
//创建初始化缓冲区
void Create_Net_Buffer(NetBufferManager * managerBuffer, int NetBufferSize);
//释放缓冲区
void Free_Net_Buffer(NetBufferManager * managerBuffer);
//填写缓冲区
void Write_Net_Buffer(NetBufferManager * managerBuffer, uint8_t* source_buf_ptr, int packet_size);
//读取缓冲区
int Read_Net_Buffer(NetBufferManager * managerBuffer, uint8_t* destination_buf_ptr, int packet_size);

#endif /* IPINPUT_H_ */
