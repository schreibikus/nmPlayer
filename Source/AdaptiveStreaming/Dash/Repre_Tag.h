#pragma once
#ifndef _Repre_Tag_H
#define _Repre_Tag_H

#include "voType.h"
#include "voSource2.h"
#include "voXMLLoad.h"
#include  "Common_Tag.h"
#ifdef _VONAMESPACE
namespace _VONAMESPACE{
#endif
#ifdef _IOS
	using namespace _VONAMESPACE;
#endif

#define RPE_ID  "id"
#define RPE_BAND_WIDTH "bandwidth"
#define RPE_QUA_RANK "qualityRanking"
#define RPE_DEP_ID "dependencyId"
#define RPE_WIDTH   "width"
#define RPE_HEIGHT				"height"
#define RPE_TYPE				"mimeType"
#define RPE_CODEC				"codecs"
#define RPE_AP                   "startWithSAP"	




class Repre_Tag:public Common_Tag
{
public:
	Repre_Tag(void);
	~Repre_Tag(void);
public:
	virtual VO_U32 Init(CXMLLoad *m_pXmlLoad,VO_VOID* pNode);
public:
		VO_CHAR * GetID(){return m_uID;}
		VO_SOURCE_TRACKTYPE GetTrackType(){return m_track_type;}
	    VO_U32 GetCodecs(){ return m_codectype;}
		VO_S32 GetHeight(){return m_height;}
		VO_S32 GetWidth(){return m_width;}
		VO_S64 GetBandWidth(){return m_bandwidth;}
		VO_S32 GetTrackCount(){return m_track_count;}
		VO_BOOL Is_TS(){return m_is_ts;}
		VO_VOID Delete(void);

private:
//	Common_Tag * m_comtag;
	VO_CHAR	m_uID[256];
	VO_CHAR m_type[256];
	VO_U32 m_codectype;
	VO_S32 m_width;
	VO_S32 m_height;		 /*!< Height */
	VO_S64 m_bandwidth;
	VO_S32 m_track_count;
	VO_BOOL m_is_ts;
	VO_SOURCE_TRACKTYPE m_track_type;
};
#ifdef _VONAMESPACE
}
#endif

#endif