Washington DC August_2019 min and max temperatures NOAA api and R                                                                            
                                                                                                                                             
github                                                                                                                                       
https://tinyurl.com/yb2dathe                                                                                                                 
https://github.com/rogerjdeangelis/utl-Washington-DC-August_2019-min-and-max-temperatures-NOAA-api-and-R                                     
                                                                                                                                             
https://tinyurl.com/y7pn6yzg                                                                                                                 
https://stackoverflow.com/questions/62600760/getting-weather-data-from-r-rnoaa                                                               
                                                                                                                                             
Somewhat useless site because it claims to be a big data but                                                                                 
limits downloads to 1,000 records.                                                                                                           
                                                                                                                                             
   Method                                                                                                                                    
     1. Go to https://www.ncdc.noaa.gov/cdo-web/token for a max of 1,000 records                                                             
     2. Install the rnoaa R package.                                                                                                         
     3. Call the getweather fuction to download and create R list                                                                            
     4. Bind the multiple dataframes in the R list into one dataframe                                                                        
     5. Convert the factors to SAS character strings                                                                                         
     6. Export the dataframe to a SAS V5 export file                                                                                         
     7. Convert the V5 export to a SAS table.                                                                                                
     8. Subset for Max and Min tempertures and plot.                                                                                         
                                                                                                                                             
/*                   _                                                                                                                       
(_)_ __  _ __  _   _| |_                                                                                                                     
| | `_ \| `_ \| | | | __|                                                                                                                    
| | | | | |_) | |_| | |_                                                                                                                     
|_|_| |_| .__/ \__,_|\__|                                                                                                                    
        |_|                                                                                                                                  
*/                                                                                                                                           
                                                                                                                                             
%let apikey=jdswq98dhffwefjwefoiwfoweifhowhf; * fake key, it will not work;                                                                  
                                                                                                                                             
%let apikey=liNHApuxZvXLqxlZCHtYrGtmSlOWUObu;                                                                                                
                                                                                                                                             
%let yrs =%str(2019:2019);            /* years of interest */                                                                                
                                                                                                                                             
%let start=%str(-08-01);              /* start and end month and year */                                                                     
%let end=%str(-08-31);                                                                                                                       
                                                                                                                                             
%let table=GHCND;                     /* NOAA dataset */                                                                                     
                                                                                                                                             
%let station=%str(GHCND:USW00024234); /* NOAA weather station */                                                                             
                                                                                                                                             
/*           _               _                                                                                                               
  ___  _   _| |_ _ __  _   _| |_                                                                                                             
 / _ \| | | | __| `_ \| | | | __|                                                                                                            
| (_) | |_| | |_| |_) | |_| | |_                                                                                                             
 \___/ \__,_|\__| .__/ \__,_|\__|                                                                                                            
                |_|                                                                                                                          
*/                                                                                                                                           
                                                                                                                                             
                                                                                                                                             
WORK.WANT total obs=286                                                                                                                      
                                                                                                                                             
        DATE          DATATYPE       STATION       VALUE  FL_M  FL_Q  FL_SO  FL_T                                                            
                                                                                                                                             
 2019-08-01T00:00:00    AWND    GHCND:USW00024234     34                W                                                                    
 2019-08-01T00:00:00    PGTM    GHCND:USW00024234   2133                W                                                                    
 2019-08-01T00:00:00    PRCP    GHCND:USW00024234      0                W                                                                    
                                                                                                                                             
 2019-08-01T00:00:00    TMAX    GHCND:USW00024234    300                W             /* Max and Nin emp */                                  
 2019-08-01T00:00:00    TMIN    GHCND:USW00024234    167                W                                                                    
                                                                                                                                             
 2019-08-01T00:00:00    WDF2    GHCND:USW00024234    240                W                                                                    
 2019-08-01T00:00:00    WDF5    GHCND:USW00024234    220                W                                                                    
 2019-08-01T00:00:00    WSF2    GHCND:USW00024234     58                W                                                                    
                                                                                                                                             
 ...                                                                                                                                         
                                                                                                                                             
                          R Package rnoaa and NOAA Website                                                                                   
                                                                                                                                             
        +---+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+                                                              
    VAL |                                                                     |                                                              
        |   Daily Min and Max Temperatures in Washinton DC August 2019        |                                                              
     31 +                                                                     + 88                                                           
     30 +    ^                                                     ^          + 86                                                           
  C  29 +    |     ^ ^               ^ ^                           |          + 84  F                                                        
  E  28 +    |     | |               | |           ^             ^ |          + 82  A                                                        
  N  27 +    |   ^ | | ^             | | ^         |             | |          + 81  H                                                        
  T  26 +    | ^ | | | | ^         ^ | | |         |       ^   ^ | | ^ ^ ^    + 79  R                                                        
  I  25 +    | | | | | | |         | | | |     ^   |       |   | | | | | |    + 77  E                                                        
  G  24 +    | | | | | | |   ^     | | | |     | ^ |       | ^ | | | | | |    + 75  N                                                        
  R  23 +    | | | | | | |   | ^   | | | |   ^ | | |   ^ ^ | | | | | | | |    + 73  H                                                        
  A  22 +    | | | | | | |   | | ^ | | | |   | | | | ^ | | | | | | | | | |    + 72  E                                                        
  D  21 +    | | | | | | | ^ | | | | | | | ^ | | | | | | | | | | | | | | |    + 70  I                                                        
  E  20 +    | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |    + 68  T                                                        
     19 +    | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |    + 66                                                           
     18 +    | v | | | | | | | | | | | | | | | | | | | | | | | | | | | v |    + 64                                                           
     17 +    v   | | v | | v v | v | | v | | | | v | | | | | v | | | |   v    + 63                                                           
     16 +        v |   | |     |   v v   v v v v   | v | | v   | v v v        + 61                                                           
     15 +          v   v v     v                   |   | |     |              + 59                                                           
     14 +                                          v   v |     v              + 57                                                           
     13 +                                                v                    + 55                                                           
        |                                                                     |                                                              
        +---+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+                                                              
           0 1 2 3 4 5 6 7 8 9 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2 2 3 3 3                                                                 
                               0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2                                                                 
                                                                                                                                             
                                          DAY                                                                                                
/*                                                                                                                                           
 _ __  _ __ ___   ___  ___ ___                                                                                                               
| `_ \| `__/ _ \ / _ \/ __/ __|                                                                                                              
| |_) | | | (_) |  __/\__ \__ \                                                                                                              
| .__/|_|  \___/ \___||___/___/                                                                                                              
|_|                                                                                                                                          
*/                                                                                                                                           
                                                                                                                                             
proc datasets lib=work;                                                                                                                      
 delete want;                                                                                                                                
run;quit;                                                                                                                                    
                                                                                                                                             
%utlfkil(d:/xpt/want.xpt);                                                                                                                   
                                                                                                                                             
%utl_submit_r64(resolve('                                                                                                                    
                                                                                                                                             
library(rnoaa);                                                                                                                              
library(dplyr);                                                                                                                              
library(SASxport);                                                                                                                           
library(data.table);                                                                                                                         
                                                                                                                                             
options(noaakey= "&apikey");                                                                                                                 
                                                                                                                                             
getweather <- function(stid) {                                                                                                               
   /* create empty list */                                                                                                                   
   wtr<-list();                                                                                                                              
   for (i in &yrs) {                                                                                                                         
      start_date <- paste0(i, "&start");                                                                                                     
      end_date <- paste0(i, "&end");                                                                                                         
                                                                                                                                             
      /* save data portion to the list (elements named for the year */                                                                       
      wtr[[as.character(i)]] <-                                                                                                              
           ncdc(datasetid="&table", stationid=stid, startdate = start_date, enddate = end_date,limit=1000)$data;                             
   };                                                                                                                                        
   /* return the full list of data frames */                                                                                                 
   return(wtr)                                                                                                                               
};                                                                                                                                           
                                                                                                                                             
washington_weather <- getweather("&station");                                                                                                
                                                                                                                                             
/* bind the dataframes in the list together into one large dataframe   */                                                                    
want<-dplyr::bind_rows(washington_weather);                                                                                                  
                                                                                                                                             
/* conver R factors to sas character strings */                                                                                              
want <- as.data.table(lapply(want, function(x) if(is.factor(x)) as.character(x) else x));                                                    
                                                                                                                                             
/* export to sas v5 transport file */                                                                                                        
write.xport(want,file="d:/xpt/want.xpt");                                                                                                    
'));                                                                                                                                         
                                                                                                                                             
libname xpt xport "d:/xpt/want.xpt";                                                                                                         
data want ;                                                                                                                                  
  set xpt.want;                                                                                                                              
run;quit;                                                                                                                                    
libname xpt clear;                                                                                                                           
                                                                                                                                             
* prep for plot;                                                                                                                             
data TMAXMIN(rename=datatype=var);                                                                                                           
  retain value . lagmax ;                                                                                                                    
  set want (where=(datatype=:"TM"));                                                                                                         
  day=input(substr(date,9,2),3.);                                                                                                            
  val=round(value/10,1);                                                                                                                     
  feh=9*val/5 + 32;                                                                                                                          
  lagmax=lag(val);                                                                                                                           
  select (datatype);                                                                                                                         
     when ('TMAX') sym='^';                                                                                                                  
     when ('TMIN') sym='v';                                                                                                                  
  end;                                                                                                                                       
  output;                                                                                                                                    
  if _n_>1 then do;                                                                                                                          
  do  y=val+1 to lagmax-1;                                                                                                                   
      sym='|';                                                                                                                               
      valsav=val;                                                                                                                            
      val=y;                                                                                                                                 
      output;                                                                                                                                
      val=valsav;                                                                                                                            
  end;                                                                                                                                       
  end;                                                                                                                                       
  keep day datatype val feh sym;                                                                                                             
run;quit;                                                                                                                                    
                                                                                                                                             
options ls=88 ps=38;                                                                                                                         
proc plot data=tmaxmin;                                                                                                                      
 plot val*day=' ' $ sym  /box haxis=0 to 32 by 1;                                                                                            
run;quit;                                                                                                                                    
                                                                                                                                             
                                                                                                                                             
                                                                                                                                             
                                                                                                                                             
