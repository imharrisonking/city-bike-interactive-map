class Trip
{
    float startid;
    float endid;
    float startlat;
    float startlon;
    float endlat;
    float endlon;
    float starttime;
    float endtime;
    
    Trip(float startid_, float endid_, float startlat_, float startlon_, float endlat_, float endlon_, float starttime_, float endtime_)
    {
      startid = startid_;
      endid = endid_;
      startlat = startlat_;
      startlon = startlon_;
      endlat = endlat_;
      endlon = endlon_;
      starttime = starttime_*1000;
      endtime = endtime_*1000;
    }
}

