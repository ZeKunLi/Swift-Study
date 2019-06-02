#ifndef _CMSDEMUX_H_
#define _CMSDEMUX_H_

#define ARMVERSION //define arm for iphone ios system 

#import  <stdio.h>
#import  <stdlib.h>
#import <macTypes.h>
#import <string.h>
#ifndef Int8
typedef char Int8;
#endif
#ifndef UInt8
typedef unsigned char UInt8;
#endif
#ifndef Int16
typedef short Int16;
#endif
#ifndef UInt16
typedef unsigned short UInt16;
#endif
#ifndef Int32
typedef int Int32;
#endif
#ifndef UInt32
//typedef unsigned int UInt32;
#endif
#ifndef Int64
#ifdef WIN32
	#include <windows.h>
	typedef __int64					Int64;
	typedef unsigned __int64		UInt64;
#else
#ifdef ARMVERSION
	typedef unsigned long long              Int64;
	typedef unsigned long long				UInt64;
#endif
#endif
#endif

#define CMS_ALIGN_SIZE		64
#define CMS_ALIGN_MASK		(CMS_ALIGN_SIZE-1)
#define PAGESIZE			8192
#define CMSMAXFRAMESIZE		(PAGESIZE*48)
#define CMSFHEXTLEN			14
#define IFRAME_OFF			0
#define IFRAME_FORWARD		1
#define IFRAME_BACKWARD		2
#define IFRAME_MASK			(1 << 22)

#define FILTER_RESET_MODE	(1 << 0)
#define REC_DATA_MODE		(1 << 1)

#define NAL_SLICE			1
#define NAL_SLICE_DPA		2
#define NAL_SLICE_DPB		3
#define NAL_SLICE_DPC		4
#define NAL_SLICE_IDR		5
#define NAL_SEI				6
#define NAL_SPS				7
#define NAL_PPS				8
#define NAL_AU_DELIMITER	9
//define typedef

/*
 如果此处报Uint32 或 Uint64 错误的话可以进行如下处理：
 1. 把下面#ifndef UInt32
 //typedef unsigned int UInt32;
 #endif
 注释掉的地方打开，如果抱redefine 的错,可以继续注释，然后添加： #import <macTypes.h>
 */
typedef int (*fpCBDataOut) (id _obj,SEL _sel, Int32 pPara,UInt8 *picpData,UInt32 piDataSize,UInt32 piFrameInfo,UInt32 piTime,UInt64 pPts);

typedef struct _DATAFILTER
{
	Int32 cbReq;
	Int32 remBytes;
	Int32 chanSkip;
	Int32 chanInfo;
	UInt32 FrameTime;
	UInt8 *cpBuf;
	UInt8 *cpOut;
	UInt32 outLimit;
	UInt32 outSize;
	UInt32 IFrameMode;
	UInt32 Skip2IFrame;
	UInt32 ResetMode;
	UInt32 DataMode;
	UInt32 SpecialPES;
	UInt64 FramePts;
	Int32 dataOutPara;
//	int (*fpDataOut) (Int32 pPara,UInt8 *picpData,UInt32 piDataSize,UInt32 piFrameInfo,UInt32 piTime,UInt64 pPts);
//    int (*fpCBDataOut) (id _obj,SEL _sel, Int32 pPara,UInt8 *picpData,UInt32 piDataSize,UInt32 piFrameInfo,UInt32 piTime,UInt64 pPts);
    fpCBDataOut _fpCBDataOut;
} DATAFILTER;

int cmsDemuxOpen();//1 call open
int cmsDemuxDataOut_OC(id _obj,SEL _sel, int hDemux,int pPara,int (*fpCBDataOut) (id _obj,SEL _sel, Int32 pPara,UInt8 *picpData,UInt32 piDataSize,UInt32 piFrameInfo,UInt32 piTime,UInt64 pPts));

//int cmsDemuxDataOut(int hDemux,int pPara,int (*pfpDataOut) (int pPara,UInt8 *picpData,UInt32 piDataSize,UInt32 piFrameInfo,UInt32 piTime,UInt64 pPts));
int cmsDemuxReset(int hDemux);
int cmsDemuxDataMode(int hDemux,UInt32 piDataMode);

int cmsDemuxDataWrite(int hDemux,UInt8 *picpBlock,UInt32 piSize);//2 put data
void cmsDemuxClose(int hDemux);//3 close

#endif
