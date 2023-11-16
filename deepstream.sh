gst-launch-1.0 \
filesrc location=/workspace/videos/streat.mp4 ! \
qtdemux ! \
h264parse ! \
nvv4l2decoder ! \
m.sink_0 nvstreammux name=m batch-size=1 width=1920 height=1080 ! \
nvinfer config-file-path=/opt/nvidia/deepstream/deepstream/sources/apps/sample_apps/deepstream-test1/dstest1_pgie_config.txt ! \
nvtracker ll-lib-file=/opt/nvidia/deepstream/deepstream/lib/libnvds_nvmultiobjecttracker.so ! \
nvvideoconvert ! \
nvdsosd ! \
nvvideoconvert ! \
nvv4l2h264enc ! \
h264parse ! \
qtmux ! \
filesink location=output.mp4
