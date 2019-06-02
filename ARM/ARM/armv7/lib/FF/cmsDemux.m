#import "cmsDemux.h"

#define cmsSTATIC	static

id m_obj;
SEL m_sel;

cmsSTATIC Int32 defDFDataOut(Int32 pPara,UInt8 *picpData,UInt32 piDataSize,UInt32 piFrameInfo,UInt32 piTime,UInt64 pPts)
{
#if 0
	UInt32 tDataSize, tChanNo;
	char tcaBuf[256];

	tDataSize = piFrameInfo & 0x000fffff;
	tChanNo = (piFrameInfo >> 23) & 0x1f;
	if (gofpa[tChanNo] == NULL)
	{
		sprintf(tcaBuf,"datafilter%02d.h264",tChanNo);
		gofpa[tChanNo] = fopen(tcaBuf,"wb");
		if (gosfpa[tChanNo] == NULL)
			return -1;
	}
	fwrite(picpData,piDataSize,1,gofpa[tChanNo]);
#endif
	return 0;
}

cmsSTATIC Int32 defDFDataOut_OC(id _obj,SEL _sel, Int32 pPara,UInt8 *picpData,UInt32 piDataSize,UInt32 piFrameInfo,UInt32 piTime,UInt64 pPts)
{
    
    
    
    
#if 0
	UInt32 tDataSize, tChanNo;
	char tcaBuf[256];
    
	tDataSize = piFrameInfo & 0x000fffff;
	tChanNo = (piFrameInfo >> 23) & 0x1f;
	if (gofpa[tChanNo] == NULL)
	{
		sprintf(tcaBuf,"datafilter%02d.h264",tChanNo);
		gofpa[tChanNo] = fopen(tcaBuf,"wb");
		if (gofpa[tChanNo] == NULL)
			return -1;
	}
	fwrite(picpData,piDataSize,1,gofpa[tChanNo]);
#endif
    
    
	return 0;
}

int cmsDemuxOpen()
{
	DATAFILTER *tstpDF;

	(tstpDF = (DATAFILTER *)malloc(sizeof(DATAFILTER)+CMS_ALIGN_SIZE+CMSMAXFRAMESIZE*2));
    
    if(tstpDF)
	{
		tstpDF->cbReq = -1;
		tstpDF->remBytes = 0;
		tstpDF->chanSkip = 1;
		tstpDF->chanInfo = 0;
		tstpDF->FrameTime = 0;
		tstpDF->cpBuf = (UInt8 *) (((UInt32) tstpDF+sizeof(DATAFILTER)+CMS_ALIGN_MASK) & ~CMS_ALIGN_MASK);
		tstpDF->cpOut = (UInt8 *) ((UInt32) tstpDF->cpBuf+CMSMAXFRAMESIZE);
		tstpDF->outLimit = CMSMAXFRAMESIZE;
		tstpDF->outSize = 0;
		tstpDF->IFrameMode = IFRAME_OFF;
		tstpDF->Skip2IFrame = 0xffffffff;
		tstpDF->ResetMode = 0;
		tstpDF->DataMode = 0;
		tstpDF->SpecialPES = 0;
		tstpDF->FramePts = 0;
		tstpDF->dataOutPara = 0;
		//tstpDF->fpDataOut = defDFDataOut;
//        tstpDF->fpCBDataOut=defDFDataOut_OC;
        tstpDF->_fpCBDataOut=NULL;
	}
	return (int) tstpDF;
}
//modify for oc
int cmsDemuxDataOut_OC(id _obj,SEL _sel, int hDemux,int pPara,int (*fpCBDataOut) (id _obj,SEL _sel, Int32 pPara,UInt8 *picpData,UInt32 piDataSize,UInt32 piFrameInfo,UInt32 piTime,UInt64 pPts))
{
    
	if (!hDemux)
		return -1;
	//((DATAFILTER *) hDemux)->fpDataOut = pfpDataOut;
	((DATAFILTER *) hDemux)->dataOutPara = pPara;
    ((DATAFILTER *)hDemux)->_fpCBDataOut=fpCBDataOut;
    
    m_obj=_obj;
    m_sel=_sel;
    
    
    //fpCBDataOut(_obj,_sel,0,
                
	return 0;
}

#if 0
int cmsDemuxDataOut(int hDemux,int pPara,int (*pfpDataOut) (int pPara,UInt8 *picpData,UInt32 piDataSize,UInt32 piFrameInfo,UInt32 piTime,UInt64 pPts))
{

	if (!hDemux)
		return -1;
	((DATAFILTER *) hDemux)->fpDataOut = pfpDataOut;
	((DATAFILTER *) hDemux)->dataOutPara = pPara;
	return 0;
}
#endif 
int cmsDemuxReset(int hDemux)
{

	if (!hDemux)
		return -1;
	((DATAFILTER *) hDemux)->ResetMode |= FILTER_RESET_MODE;
	return 0;
}

int cmsDemuxDataMode(int hDemux,UInt32 piDataMode)
{

	if (!hDemux)
		return -1;
	((DATAFILTER *) hDemux)->DataMode = piDataMode;
	((DATAFILTER *) hDemux)->ResetMode |= REC_DATA_MODE;
	return 0;
}

cmsSTATIC UInt32 cmsGetPts(UInt8 *pBuf,UInt32 *pPSSize,UInt32 *pStreamID,UInt64 *pPts)
{
	UInt32 tPacketLen, tnExtraLen;
	UInt32 tnOff, tPSSize, tHeadLen;
	UInt32 tSysLen, tnOff0;
	UInt8 *tcpPS;
	UInt64 tPts;

	tnOff = tnExtraLen = 0;
	tPSSize = *pPSSize;
	if (tnOff+14 < tPSSize && pBuf[0] == 0x00 && pBuf[1] == 0x00 && pBuf[2] == 0x01 && pBuf[3] == 0xBA)	/* pack header */
	{
		tPacketLen = 14+(pBuf[13] & 0x07);
		tnOff += tPacketLen;
		pBuf += tPacketLen;
	}
	if (tnOff+6 < tPSSize && pBuf[0] == 0x00 && pBuf[1] == 0x00 && pBuf[2] == 0x01 && pBuf[3] == 0xBB)	/* system header */
	{
		tPacketLen = (UInt32) (((pBuf[4] << 8) | pBuf[5])+6);
		tnOff += tPacketLen;
		pBuf += tPacketLen;
	}
	if (tnOff+6 < tPSSize && pBuf[0] == 0x00 && pBuf[1] == 0x00 && pBuf[2] == 0x01 && pBuf[3] == 0xBC)	/* stream map */
	{
		tPacketLen = (UInt32) (((pBuf[4] << 8) | pBuf[5])+6);
		tnOff += tPacketLen;
		pBuf += tPacketLen;
	}
	if (tnOff+14 < tPSSize && pBuf[0] == 0x00 && pBuf[1] == 0x00 && pBuf[2] == 0x01
		&& ((pBuf[3] >= 0xC0 && pBuf[3] <= 0xDF )			/* audio */
			|| (pBuf[3] >= 0xE0 && pBuf[3] <= 0xEF)))		/*video */
	{
		*pStreamID = (UInt32) pBuf[3];
		tPacketLen = (UInt32) ((pBuf[4] << 8) | pBuf[5]);
		tHeadLen = (UInt32) (pBuf[8]+9);
		if (pBuf[7] & 0x80)
		{
			tPts = (UInt64) (((UInt64) (pBuf[9] & 0x0e) << 29)
						| (pBuf[10] << 22)
						| ((pBuf[11] & 0xfe) << 14)
						| (pBuf[12] << 7)
						| ((pBuf[13] & 0xfe) >> 1));
			*pPts = tPts*100/9;
		}
		else
			*pPts += 40000;
		tnOff += tHeadLen;
		pBuf += tHeadLen;
		tnOff0 = tnOff;
		while (tPacketLen >= 65500)
		{
			tHeadLen = (UInt32) (tHeadLen-6);
			tnOff += (tPacketLen-tHeadLen);
			if (tnOff+9 >= tPSSize)
				break;
			tcpPS = pBuf+tPacketLen-tHeadLen;
			if (tcpPS[0] != 0x00 || tcpPS[1] != 0x00 || tcpPS[2] != 0x01
					|| tcpPS[3] < 0xC0 || tcpPS[3] > 0xEF)
			{
				break;
			}
			tSysLen = (UInt32) (tcpPS[8]+9);
			if (tnOff+tSysLen >= tPSSize)
			{
				tPSSize = tnOff;
				break;
			}
			tnExtraLen += tSysLen;
			tPacketLen = (UInt32) ((tcpPS[4] << 8) | tcpPS[5]);
			tHeadLen = (UInt32) (tcpPS[8]+9);
			memcpy((void *) tcpPS,(const void *) (tcpPS+tSysLen),tPSSize-tnOff-tSysLen);
			pBuf = tcpPS;
		}
	}
	else
	{
		*pPts += 40000;
		tnOff0 = tnOff;
	}
	if (tnOff0+tnExtraLen < tPSSize)
	{
		*pPSSize = tPSSize-tnOff0-tnExtraLen;
		return tnOff0;
	}
	return 0;
}

Int32 cmsUserDataFilter(UInt8 *picpBlock, UInt8 *pocpUserData)
{
	UInt32 tnUserSize = 0;
	UInt8 tbChar0, tbChar1, tbChar2;
	tbChar0 = picpBlock[0];
	tbChar1 = picpBlock[1];
	tbChar2 = picpBlock[2];

	while (tnUserSize < 72)
	{
		if (tbChar0 == 0x00 && tbChar1 == 0x00 && tbChar2 == 0x03)
		{
			*pocpUserData++ = 0;
			*pocpUserData++ = 0;
			picpBlock += 3;
			tnUserSize += 2;
			tbChar0 = picpBlock[0];
			tbChar1 = picpBlock[1];
			tbChar2 = picpBlock[2];
			continue;
		}
		*pocpUserData = *picpBlock;
		
		tbChar0 = tbChar1;
		tbChar1 = tbChar2;
		tbChar2 = picpBlock[3];
		
		picpBlock++;
		pocpUserData++;
		tnUserSize++;
	}
	return 0;
}

Int32 cmsGetUserData(UInt8 *picpBlock,Int32 piBufSize,UInt32 *ponpOff,UInt32 *ponpSize)
{
	UInt8 tbChar0, tbChar1, tbChar2, tbChar3, tbChar4;
	UInt32 tnUsrSize = 0, tnOff = 0;

	tbChar0 = picpBlock[0];
	tbChar1 = picpBlock[1];
	tbChar2 = picpBlock[2];
	tbChar3 = picpBlock[3];
	tbChar4 = picpBlock[4];
	while (piBufSize > 7)
	{
		if (tbChar0 == 0x00 && tbChar1 == 0x00 && tbChar2 == 0x01 && tbChar3 == 0x06 && tbChar4 == 0xf0)
		{
			while (piBufSize > 5 && picpBlock[5] == 0xff)
			{
				tnUsrSize += 255;
				tnOff++;
				picpBlock++;
				piBufSize--;
			}
			tnUsrSize += picpBlock[5];
			tnOff += 6;
			break;
		}
		tbChar0 = tbChar1;
		tbChar1 = tbChar2;
		tbChar2 = tbChar3;
		tbChar3 = tbChar4;
		tbChar4 = picpBlock[5];
		tnOff++;
		picpBlock++;
		piBufSize--;
	}
	*ponpOff = tnOff;
	*ponpSize = tnUsrSize;
	return 0;
}

cmsSTATIC Int32 FindNextStart(UInt8 *picpBlock,Int32 piBufSize,UInt32 *ponpOff,UInt32 *ponpSize)
{
	UInt8 tbChar0, tbChar1, tbChar2, tbChar3;
	UInt32 tPacketLen, tHeadLen;

	tbChar0 = picpBlock[0];
	tbChar1 = picpBlock[1];
	tbChar2 = picpBlock[2];
	tbChar3 = picpBlock[3];
	while (piBufSize > 0)
	{
		if (tbChar0 == 0x00 && tbChar1 == 0x00 && tbChar2 == 0x01
			&& (tbChar3 == 0xBA || tbChar3 == 0xBB || tbChar3 == 0xBC ||( tbChar3 >= 0xC0 && tbChar3 <= 0xEF)))
		{
			break;
		}
		tbChar0 = tbChar1;
		tbChar1 = tbChar2;
		tbChar2 = tbChar3;
		tbChar3 = picpBlock[4];
		picpBlock++;
		piBufSize--;
	}
	if (tbChar3 == 0xBA)
	{
		*ponpOff = 14+(picpBlock[13] & 0x07);
		*ponpSize = 0;
	}
	else if (tbChar3 == 0xBB || tbChar3 == 0xBC)
	{
		*ponpOff = (UInt32) (((picpBlock[4] << 8) | picpBlock[5])+6);
		*ponpSize = 0;
	}
	else if (tbChar3 >= 0xC0 && tbChar3 <= 0xEF)
	{
		tPacketLen = (UInt32) ((picpBlock[4] << 8) | picpBlock[5]);
		tHeadLen = (UInt32) (picpBlock[8]+9);
		*ponpOff = tHeadLen;
		*ponpSize = (UInt32) (tPacketLen-tHeadLen+6);
	}
	return piBufSize;
}

#if defined WIN32
__declspec(dllexport) int cmsGetStreamSeconds(UInt8 *picpBlock,UInt32 piSize,UInt32 *pStreamID,UInt32 *pSeconds)
{
	UInt32 tnOff, tnStreamSize = 0;
	Int32 tnLeftSize, tnSize = (Int32) piSize;
	UInt32 tPacketLen, tHeadLen;
	UInt64 tPts;
	UInt8 *tcpBuf = picpBlock;

	while (tnSize > CMSFHEXTLEN)
	{
		tnLeftSize = FindNextStart(tcpBuf,tnSize-CMSFHEXTLEN,&tnOff,&tnStreamSize);
		tcpBuf += tnSize-tnLeftSize-CMSFHEXTLEN;
		tnSize = tnLeftSize+CMSFHEXTLEN;
		if (!tnLeftSize)
			break;
		if (tnStreamSize == 0)
		{
			tcpBuf += tnOff;
			tnSize -= tnOff;
			continue;
		}
		if (((tnStreamSize+tnOff) & 0x000fffff) == 0x000fffff)
		{
			tcpBuf++;
			tnSize--;
			continue;
		}
		if (tnSize > 13)
		{
			*pStreamID = (UInt32) tcpBuf[3];
			tPacketLen = (UInt32) ((tcpBuf[4] << 8) | tcpBuf[5]);
			tHeadLen = (UInt32) (tcpBuf[8]+9);
			if (tcpBuf[7] & 0x80)
			{
				tPts = (UInt64) (((UInt64) (tcpBuf[9] & 0x0e) << 29)
							| (tcpBuf[10] << 22)
							| ((tcpBuf[11] & 0xfe) << 14)
							| (tcpBuf[12] << 7)
							| ((tcpBuf[13] & 0xfe) >> 1));
				*pSeconds = (UInt32) (tPts*100/9000000);
				return 0;
			}
		}
		break;
	}
	return -1;
}
#endif

cmsSTATIC Int32 DFOutIFrames(DATAFILTER *pistpDF,UInt8 *picpBlock,UInt32 piSize)
{
	Int32 tregi, tIFrames = 0;
	UInt32 tFrameTime, tchanInfo;
	Int32 tnRemBytes = -1;
	Int32 tnRet = 0;
	Int32 tnLeftSize, tnCheckSize;
	UInt32 tnSVMSize, tnDataSize, tnSize = (Int32) piSize;//modify by 李兰平
	UInt32 tnExtraLen, tnStreamID;
	UInt32 tnOff, tnStreamSize = 0;
	Int32 tnOutSize = 0, tLastITag = 0;
	UInt32 tnaSize[128];
	UInt8 *tcpBuf = picpBlock, *tcaIBuf[128];
	UInt8 *tcpOutBuf = picpBlock;
	int tSpecialPES = 0, tLastPES = 0;
	int tRemContinue = 1;

	do
	{
		tnLeftSize = FindNextStart(tcpBuf,tnSize-CMSFHEXTLEN,&tnOff,&tnStreamSize);
		tnCheckSize = tnSize;
		tcpBuf += tnSize-tnLeftSize-CMSFHEXTLEN;
		tnSize = tnLeftSize+CMSFHEXTLEN;
		if (tnLeftSize)
		{
			if (tnRemBytes == -1)
				tnRemBytes = tnCheckSize-tnLeftSize;
			if (tnStreamSize == 0)
			{
				tcpBuf += tnOff;
				tnSize -= tnOff;
				continue;
			}
			tnSVMSize = tnStreamSize+tnOff;
			tnDataSize = tnSVMSize & 0x000fffff;
			if (tnDataSize == 0x000fffff)
			{
				tcpBuf++;
				tnSize--;
				continue;
			}
			if (tnDataSize > tnSize)
				break;
			if (tRemContinue && (tcpBuf[7] & 0xC0) == 0)
				tnRemBytes += tnDataSize;
			else
				tRemContinue = 0;
			if (tLastPES && (tcpBuf[7] & 0xC0) && tLastITag)
			{
				tnaSize[tIFrames] = tnOutSize;
				tcaIBuf[tIFrames++] = tcpOutBuf;
				if (tIFrames >= 128)
				{
					tnRemBytes = (Int32) (tcpBuf-picpBlock);
					tIFrames = 0;
				}
				tnOutSize = 0;
				tLastITag = 0;
			}
			tSpecialPES = ((tcpBuf[4] << 8) | tcpBuf[5]) >= 65500;
			if (!tSpecialPES)
			{
				if (tLastPES && tLastITag)
				{
					tnaSize[tIFrames] = tnOutSize+tnDataSize;
					tcaIBuf[tIFrames++] = tcpOutBuf;
					if (tIFrames >= 128)
					{
						tnRemBytes = (Int32) (tcpBuf-picpBlock);
						tIFrames = 0;
					}
					tnOutSize = 0;
					tLastITag = 0;
				}
				else if (tnOff >= 10 && tcpBuf[3] >= 0xE0 && tcpBuf[3] <= 0xEF
					&& ((tcpBuf[tnOff+4] & 0x1f) == NAL_SLICE_IDR
						|| (tcpBuf[tnOff+4] & 0x1f) == NAL_SPS
						|| (tcpBuf[tnOff+4] & 0x1f) == NAL_PPS))
				{
					tnaSize[tIFrames] = tnDataSize;
					tcaIBuf[tIFrames++] = tcpBuf;
					if (tIFrames >= 128)
					{
						tnRemBytes = (Int32) (tcpBuf-picpBlock);
						tIFrames = 0;
					}
				}
			}
			else
			{
				if (tnOff >= 10 && tcpBuf[3] >= 0xE0 && tcpBuf[3] <= 0xEF
					&& ((tcpBuf[tnOff+4] & 0x1f) == NAL_SLICE_IDR
						|| (tcpBuf[tnOff+4] & 0x1f) == NAL_SPS
						|| (tcpBuf[tnOff+4] & 0x1f) == NAL_PPS))
				{
					tLastITag = 1;
					tnOutSize = tnDataSize;
					tcpOutBuf = tcpBuf;
				}
				else if (tLastITag)
					tnOutSize += tnDataSize;
			}
			tLastPES = tSpecialPES;
			tcpBuf += tnDataSize;
			tnSize -= tnDataSize;
		}
	} while (tnLeftSize);
	for (tregi = tIFrames; tregi > 0; tregi--)
	{
		tcpBuf = tcaIBuf[tregi-1];
		tnSVMSize = tnaSize[tregi-1];
		tFrameTime = 0;
		tchanInfo = 0;
		tnSVMSize &= 0x000fffff;
		if (tnSVMSize != 0x000fffff)
		{
			tnExtraLen = cmsGetPts(tcpBuf,&tnSVMSize,&tnStreamID,&pistpDF->FramePts);
			if (tnStreamID >= 0xE0 && tnStreamID <= 0xEF)
			{
				tchanInfo |= 1;
			}
			if (pistpDF->IFrameMode == IFRAME_OFF || (tchanInfo & 0x01))
                
//				tnRet |= pistpDF->fpDataOut(pistpDF->dataOutPara,tcpBuf+tnExtraLen,tnSVMSize,tchanInfo,tFrameTime,pistpDF->FramePts);
                //call func pointer 
            tnRet |= pistpDF->_fpCBDataOut(m_obj,m_sel,pistpDF->dataOutPara,tcpBuf+tnExtraLen,tnSVMSize,tchanInfo,tFrameTime,pistpDF->FramePts);
			tchanInfo &= ~1;
		}
	}
	if (tnRemBytes+tnRemBytes <= (Int32) piSize)
	{
		if ((UInt32) (tnRemBytes+8) < piSize)
			tnRemBytes += 8;
		memcpy((void *) (picpBlock+piSize-tnRemBytes),(const void *) picpBlock,tnRemBytes);
		pistpDF->remBytes = tnRemBytes;
	}
	return tnRet;
}

int cmsDemuxDataWrite(int hDemux,UInt8 *picpBlock,UInt32 piSize)
{
	Int32 tnRet = 0, tnLeftSize, tcbReq;
	UInt32 tnSVMSize, tnDataSize, tnSize;
	Int32 tIFrameMode, tchanInfo;
	UInt32 tSkip2IFrame;
	UInt32 tnExtraLen, tnStreamID;
	UInt32 tnOff, tnStreamSize = 0;
	UInt8 *tcpBuf;
	DATAFILTER *tstpDF = (DATAFILTER *) hDemux;

    
//    tstpDF->_fpCBDataOut(m_obj,m_sel, tstpDF->dataOutPara,tstpDF->cpOut+tnExtraLen,tnSVMSize,tchanInfo,tstpDF->FrameTime,tstpDF->FramePts);
#if 1
	if (tstpDF->ResetMode & FILTER_RESET_MODE)
	{
		tstpDF->ResetMode &= ~FILTER_RESET_MODE;
		tstpDF->cbReq = -1;
		tstpDF->remBytes = 0;
		tstpDF->chanSkip = 1;
		tstpDF->chanInfo = 0;
		tstpDF->Skip2IFrame = 0xffffffff;
		tstpDF->outSize = 0;
		tstpDF->SpecialPES = 0;
		tstpDF->FramePts = 0;
	}
	if (tstpDF->ResetMode & REC_DATA_MODE)
	{
		tstpDF->ResetMode &= ~REC_DATA_MODE;
		if ((tstpDF->IFrameMode == IFRAME_BACKWARD && tstpDF->DataMode != IFRAME_BACKWARD)
			|| (tstpDF->IFrameMode != IFRAME_BACKWARD && tstpDF->DataMode == IFRAME_BACKWARD))
		{
			tstpDF->remBytes = 0;
			tstpDF->chanInfo = 0;
			tstpDF->cbReq = -1;
			tstpDF->chanSkip = 1;
			tstpDF->Skip2IFrame = 0xffffffff;
			tstpDF->outSize = 0;
			tstpDF->SpecialPES = 0;
			tstpDF->FramePts = 0;
		}
		tstpDF->IFrameMode = tstpDF->DataMode;
	}
	tIFrameMode = tstpDF->IFrameMode;
	tnSize = piSize+tstpDF->remBytes;
	if (tIFrameMode == IFRAME_BACKWARD)
	{
		tcpBuf = tstpDF->cpBuf+CMSMAXFRAMESIZE-tnSize;
		memcpy((void *) tcpBuf,(const void *) picpBlock,piSize);
		if (tnSize+PAGESIZE > CMSMAXFRAMESIZE)
			return DFOutIFrames(tstpDF,tcpBuf,tnSize);
		tstpDF->remBytes = tnSize;
		return 0;
	}
	tcpBuf = picpBlock;
	if (tstpDF->remBytes && tstpDF->remBytes <= CMSFHEXTLEN)
	{
		tcpBuf = picpBlock-tstpDF->remBytes;
		memcpy(tcpBuf,tstpDF->cpBuf,tstpDF->remBytes);
		tstpDF->remBytes = 0;
	}
	tSkip2IFrame = tstpDF->Skip2IFrame;
	tcbReq = tstpDF->cbReq;
	tchanInfo = tstpDF->chanInfo;
	while (tnSize > CMSFHEXTLEN || (tcbReq > 0 && tnSize > 0))
	{
		if (tcbReq > 0)
		{
			tnDataSize = tnSize > tcbReq ? tcbReq : tnSize;
			tcbReq -= tnDataSize;
			if (tcbReq == 0)
				tchanInfo |= (1 << 30);
		}
		else
		{
			if (tcbReq == 0)
			{
				if (tcpBuf[0] != 0x00 || tcpBuf[1] != 0x00 || tcpBuf[2] != 0x01
					|| (tcpBuf[3] != 0xBA && tcpBuf[3] != 0xBB && tcpBuf[3] != 0xBC
						&& (tcpBuf[3] < 0xC0 || tcpBuf[3] > 0xEF)))
				{
					tcbReq = -1;
					tSkip2IFrame |= 1;
					continue;
				}
			}
			tnLeftSize = FindNextStart(tcpBuf,tnSize-CMSFHEXTLEN,&tnOff,&tnStreamSize);
			if (!tnLeftSize)
			{
				tcpBuf += tnSize-CMSFHEXTLEN;
				if (tcpBuf[0] == 0x00 || tcpBuf[1] == 0x00 || tcpBuf[2] == 0x00 || tcpBuf[3] == 0x00
					|| tcpBuf[4] == 0x00 || tcpBuf[5] == 0x00 || tcpBuf[6] == 0x00 || tcpBuf[7] == 0x00
					|| tcpBuf[8] == 0x00 || tcpBuf[9] == 0x00 || tcpBuf[10] == 0x00 || tcpBuf[11] == 0x00
					|| tcpBuf[12] == 0x00 || tcpBuf[13] == 0x00)
				{
					memcpy(tstpDF->cpBuf,tcpBuf,CMSFHEXTLEN);
					tstpDF->remBytes = CMSFHEXTLEN;
				}
				tstpDF->cbReq = tcbReq;
				tstpDF->Skip2IFrame = tSkip2IFrame;
				tstpDF->chanInfo = tchanInfo;
				return 0;
			}
			tcpBuf += tnSize-tnLeftSize-CMSFHEXTLEN;
			tnSize = tnLeftSize+CMSFHEXTLEN;
			if (tstpDF->SpecialPES && (tcpBuf[7] & 0xC0))
			{
				tnSVMSize =tstpDF->outSize;
				tnExtraLen = cmsGetPts(tstpDF->cpOut,&tnSVMSize,&tnStreamID,&tstpDF->FramePts);
				if (tnStreamID >= 0xC0 && tnStreamID <= 0xDF)		/* audio */
					tchanInfo |= (1 << 31);
				if (tnStreamID >= 0xE0 && tnStreamID <= 0xEF
					&& ((tstpDF->cpOut[tnExtraLen+4] & 0x1f) == NAL_SLICE_IDR
					|| (tstpDF->cpOut[tnExtraLen+4] & 0x1f) == NAL_SPS
					|| (tstpDF->cpOut[tnExtraLen+4] & 0x1f) == NAL_PPS))
				{
					tchanInfo |= 1;
				}
				if (tstpDF->IFrameMode == IFRAME_OFF || (tchanInfo & 0x01))
                    
//					tnRet |= tstpDF->fpDataOut(tstpDF->dataOutPara,tstpDF->cpOut+tnExtraLen,tnSVMSize,tchanInfo,tstpDF->FrameTime,tstpDF->FramePts);
                    
                    tnRet |= tstpDF->_fpCBDataOut(m_obj,m_sel, tstpDF->dataOutPara,tstpDF->cpOut+tnExtraLen,tnSVMSize,tchanInfo,tstpDF->FrameTime,tstpDF->FramePts);
                
				tstpDF->outSize = 0;
				tchanInfo &= ~(1 | (1 << 31));
			}
			tstpDF->SpecialPES = ((tcpBuf[4] << 8) | tcpBuf[5]) >= 65500;
			tchanInfo = 0;
			tnSVMSize = tnStreamSize+tnOff;
			if (tnSVMSize == 0x000fffff)
				tnSVMSize = 0;
			tstpDF->chanSkip = 0;
			if (tnSize >= tnSVMSize)
			{
				tcbReq = 0;
				tnDataSize = tnSVMSize;
				if (tnStreamSize)
					tchanInfo |= (1 << 30);
			}
			else
			{
				tcbReq = tnSVMSize-tnSize;
				tnDataSize = tnSize;
			}
		}
		if ((tstpDF->chanSkip & 1) == 0 && tnDataSize)
		{
			while (tstpDF->outSize+tnDataSize > tstpDF->outLimit)
			{
				UInt8 *ttcpOut = tstpDF->cpOut;

				if ((tstpDF->cpOut = (UInt8 *) malloc(tstpDF->outLimit+PAGESIZE*8)) == NULL)
				{
					tstpDF->cpOut = ttcpOut;
					return -1;
				}

				if (tstpDF->outSize)
					memcpy((void *) tstpDF->cpOut,(const void *) ttcpOut,tstpDF->outSize);
				free((void *) ttcpOut);
				tstpDF->outLimit += PAGESIZE*8;
			}
			memcpy((void *) (tstpDF->cpOut+tstpDF->outSize),(const void *) tcpBuf,tnDataSize);
			tstpDF->outSize += tnDataSize;
			if ((tchanInfo & (1 << 30)) && !tstpDF->SpecialPES)
			{
				tchanInfo &= ~(3 << 30);
				tnSVMSize = tstpDF->outSize;
				tnExtraLen = cmsGetPts(tstpDF->cpOut,&tnSVMSize,&tnStreamID,&tstpDF->FramePts);
				if (tnStreamID >= 0xC0 && tnStreamID <= 0xDF)		/* audio */
					tchanInfo |= (1 << 31);
				if (tnStreamID >= 0xE0 && tnStreamID <= 0xEF
					&& ((tstpDF->cpOut[tnExtraLen+4] & 0x1f) == NAL_SLICE_IDR
					|| (tstpDF->cpOut[tnExtraLen+4] & 0x1f) == NAL_SPS
					|| (tstpDF->cpOut[tnExtraLen+4] & 0x1f) == NAL_PPS))
				{
					tchanInfo |= 1;
				}
				if (tstpDF->IFrameMode == IFRAME_OFF || (tchanInfo & 0x01))
//					tnRet |= tstpDF->fpDataOut(tstpDF->dataOutPara,tstpDF->cpOut+tnExtraLen,tnSVMSize,tchanInfo,tstpDF->FrameTime,tstpDF->FramePts);
                    tnRet |= tstpDF->_fpCBDataOut(m_obj,m_sel, tstpDF->dataOutPara,tstpDF->cpOut+tnExtraLen,tnSVMSize,tchanInfo,tstpDF->FrameTime,tstpDF->FramePts);
                
				tstpDF->outSize = 0;
				tchanInfo &= ~(1 | (1 << 31));
			}
		}
		tcpBuf += tnDataSize;
		tnSize -= tnDataSize;
	}
	for (tnLeftSize = 0; tnLeftSize < tnSize; tnLeftSize++)
	{
		if (tcpBuf[tnLeftSize] == 0x00)
			break;
	}
	if (tnLeftSize < tnSize)
	{
		memcpy(tstpDF->cpBuf,tcpBuf,tnSize);
		tstpDF->remBytes = tnSize;
	}
	tstpDF->cbReq = tcbReq;
	tstpDF->Skip2IFrame = tSkip2IFrame;
	tstpDF->chanInfo = tchanInfo;
#endif
    
	return tnRet;
}

void cmsDemuxClose(int hDemux)
{

	if (hDemux)
		free((void *) hDemux);
}
