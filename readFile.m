function [TS,Resp,BP,ECG]=readFile(filePath)  
    disp(['reading ' filePath]);
    file=[filePath];
    fid=fopen(file,'rt');
    fgetl(fid); 
    fgetl(fid);
    fgetl(fid); 
    fgetl(fid);
    fgetl(fid); %ignore first five lines

    TS=[];
    Ch1=[];
    Ch2=[];
    Ch3=[];
    % Ch4=[];

    n=1;

    while 1
        s1=fgetl(fid); % reads a line from the .txt file
        if ~ischar(s1), 
            break,
        end 
        sp=isspace(s1);
        sp_pos=find(sp);
        sp1=sp_pos(1);         % index of the first space
        Secs=str2double(s1(1:sp1));
        TS=[TS; Secs];
        
   %************************************  Channel 1  *******************
        sp2=sp_pos(2);
        col_2=str2double(s1(sp1+1:sp2));
        Ch1=[Ch1; col_2];
        
   %************************************  Channel 2  *******************
        sp3=sp_pos(3);
        col_3=str2double(s1(sp2+1:sp3));
        Ch2=[Ch2; col_3];
   %************************************  Channel 3  *******************
        col_4=str2double(s1(sp3+1:end));
        Ch3=[Ch3; col_4];
     
        n=n+1;
    end
    fclose(fid);
    Resp=Ch1;
    BP=Ch2;
    ECG=Ch3;      
end