/*
 * utils.c
 *
 *  Created on: 2016-5-18
 *      
 */


//#include "avutil.h"
#import "utils.h"


void Create_Net_Buffer(NetBufferManager * managerBuffer, int NetBufferSize) {
	pthread_mutex_init(&managerBuffer->locker, NULL);
	pthread_cond_init(&managerBuffer->cond, NULL);
	managerBuffer->net_buffer_original_ptr = (uint8_t*)av_mallocz(sizeof(uint8_t)*NetBufferSize);
	managerBuffer->read_ptr = managerBuffer->write_ptr = 0;
	managerBuffer->net_buf_size = NetBufferSize;
    
//	fprintf(stdout, "managerBuffer->bufsize=%d\n", size);
}

void Free_Net_Buffer(NetBufferManager * managerBuffer) {
	pthread_mutex_destroy(&managerBuffer->locker);
	pthread_cond_destroy(&managerBuffer->cond);
	av_free(managerBuffer->net_buffer_original_ptr);
}

void Write_Net_Buffer(NetBufferManager * managerBuffer, uint8_t* source_buf_ptr, int packet_size) {
    
	uint8_t* dst = managerBuffer->net_buffer_original_ptr + managerBuffer->write_ptr;

	pthread_mutex_lock(&managerBuffer->locker);
    
//    NSLog(@"put_data write_ptr+size==%d,managerBuffer->bufferSize==%d",managerBuffer->write_ptr+packet_size,managerBuffer->net_buf_size);
    
    //写到缓冲末尾处的时候，余下的空间写不下8K数据包，就需要拆包处理了，假如写2K就满了，那么余下的
    //6K还要从前缓冲区的起始位置进行覆盖。
	if ((managerBuffer->write_ptr + packet_size) > managerBuffer->net_buf_size) {
        
		memcpy(dst, source_buf_ptr, (managerBuffer->net_buf_size - managerBuffer->write_ptr));
        
		memcpy(managerBuffer->net_buffer_original_ptr, source_buf_ptr+(managerBuffer->net_buf_size - managerBuffer->write_ptr), packet_size-(managerBuffer->net_buf_size - managerBuffer->write_ptr));
        
        
        
	} else {
        
    //这种情况正常的写
        
		memcpy(dst, source_buf_ptr, packet_size*sizeof(uint8_t));
        
    }
    
	managerBuffer->write_ptr = (managerBuffer->write_ptr + packet_size) % managerBuffer->net_buf_size;

//    NSLog(@"接收线程正在写缓冲信息：buffer size >>>>>>>> %d\r\n writting packet size >>>>>>>> %d\r\n writted data size >>>>>>>> %d\r\n",managerBuffer->net_buf_size,packet_size,managerBuffer->write_ptr);

	pthread_cond_signal(&managerBuffer->cond);
	pthread_mutex_unlock(&managerBuffer->locker);
}

int Read_Net_Buffer(NetBufferManager * managerBuffer, uint8_t* destination_buf_ptr, int packet_size) {
    
	uint8_t* src = managerBuffer->net_buffer_original_ptr + managerBuffer->read_ptr;
    
	int wrap = 0; //判断是否需要分两次读
    pthread_mutex_lock(&managerBuffer->locker);
    
	int pos = managerBuffer->write_ptr;

    //写的位置跑到读的位置后面去了，那可能是出现了拆包写情况，那就需要分两次去读
    //一个完整的8K数据包
	if (pos < managerBuffer->read_ptr) {
        
//		pos += managerBuffer->buf; //此处可能没有被处理，因为pos的位置已经是managerBuffer->buf
        
		wrap = 1;
	}
//    NSLog(@"managerBuffer->read_ptr + size===%d,pos===%d",managerBuffer->read_ptr + packet_size,pos);
    
    //this place allways is true ,so don't get data  
	if ( (managerBuffer->read_ptr + packet_size) > pos) {
       
		pthread_mutex_unlock(&managerBuffer->locker);
        
		return 1;
	}
    
    //具体执行分两次读取一个完整的8K数据包
	if (wrap/*判断是否需要拆包处理 */) {

		memcpy(destination_buf_ptr, src, (managerBuffer->net_buf_size - managerBuffer->read_ptr));
        
		memcpy(destination_buf_ptr+(managerBuffer->net_buf_size - managerBuffer->read_ptr), src+(managerBuffer->net_buf_size - managerBuffer->read_ptr), packet_size-(managerBuffer->net_buf_size - managerBuffer->read_ptr));
        

	} else {
        
		memcpy(destination_buf_ptr, src, sizeof(uint8_t)*packet_size);
        
	}
	managerBuffer->read_ptr = (managerBuffer->read_ptr + packet_size) % managerBuffer->net_buf_size;
    
   	pthread_mutex_unlock(&managerBuffer->locker);

   
	return 0;
}

