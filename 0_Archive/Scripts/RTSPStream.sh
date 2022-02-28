#/bin/bash
#
cvlc --no-audio rtsp://admin:Onvif1921680190@192.168.0.190:554/onvif1 --sout="#standard{mux="ffmpeg",access="file",dst="/mnt/Temporário/output_file.ts"}" --no-sout-audio
exit
