#
# Build file to create one big executable / shared library
# with aapt and all depending libs
#

LOCAL_PATH:= $(call my-dir)

#############################################################################
# libpng definitions
#############################################################################
libpng_SRC_FILES := \
	libpng/jni/png.c \
	libpng/jni/pngerror.c \
	libpng/jni/pngget.c \
	libpng/jni/pngmem.c \
	libpng/jni/pngpread.c \
	libpng/jni/pngread.c \
	libpng/jni/pngrio.c \
	libpng/jni/pngrtran.c \
	libpng/jni/pngrutil.c \
	libpng/jni/pngset.c \
	libpng/jni/pngtest.c \
	libpng/jni/pngtrans.c \
	libpng/jni/pngwio.c \
	libpng/jni/pngwrite.c \
	libpng/jni/pngwtran.c \
	libpng/jni/pngwutil.c \
	libpng/jni/arm/arm_init.c \
	libpng/jni/arm/filter_neon.S \
	libpng/jni/arm/filter_neon_intrinsics.c

libpng_C_INCLUDES := $(LOCAL_PATH)/libpng/jni
#############################################################################

# expat definitions
#############################################################################
expat_SRC_FILES := \
	expat/jni/lib/xmlparse.c \
	expat/jni/lib/xmlrole.c \
	expat/jni/lib/xmltok.c

expat_CFLAGS += -DHAVE_EXPAT_CONFIG_H
expat_C_INCLUDES := $(LOCAL_PATH)/expat/jni/lib

#############################################################################
# liblog definitions
#############################################################################
liblog_SRC_FILES := liblog/jni/logd_write.c
liblog_CFLAGS := -DHAVE_PTHREADS
liblog_C_INCLUDES += $(LOCAL_PATH)/libcutils/jni/include

#############################################################################
# libcutils definitions
#############################################################################
libcutils_SRC_FILES := \
	libcutils/jni/array.c \
	libcutils/jni/hashmap.c \
	libcutils/jni/atomic.c.arm \
	libcutils/jni/native_handle.c \
	libcutils/jni/buffer.c \
	libcutils/jni/socket_inaddr_any_server.c \
	libcutils/jni/socket_local_client.c \
	libcutils/jni/socket_local_server.c \
	libcutils/jni/socket_loopback_client.c \
	libcutils/jni/socket_loopback_server.c \
	libcutils/jni/socket_network_client.c \
	libcutils/jni/config_utils.c \
	libcutils/jni/cpu_info.c \
	libcutils/jni/load_file.c \
	libcutils/jni/open_memstream.c \
	libcutils/jni/strdup16to8.c \
	libcutils/jni/strdup8to16.c \
	libcutils/jni/record_stream.c \
	libcutils/jni/process_name.c \
	libcutils/jni/properties.c \
	libcutils/jni/threads.c \
	libcutils/jni/sched_policy.c \
	libcutils/jni/iosched_policy.c \
	libcutils/jni/str_parms.c \
  libcutils/jni/abort_socket.c \
  libcutils/jni/selector.c \
  libcutils/jni/tztime.c \
  libcutils/jni/zygote.c \
  libcutils/jni/ashmem-dev.c \
  libcutils/jni/mq.c \
  libcutils/jni/uevent.c
  
ifeq ($(TARGET_ARCH),arm)
libcutils_SRC_FILES += libcutils/jni/arch-arm/memset32.S
else  # !arm
ifeq ($(TARGET_ARCH),sh)
libcutils_SRC_FILES += libcutils/jni/memory.c libcutils/jni/atomic-android-sh.c
else  # !sh
ifeq ($(TARGET_ARCH_VARIANT),x86-atom)
libcutils_CFLAGS += -DHAVE_MEMSET16 -DHAVE_MEMSET32
libcutils_SRC_FILES += libcutils/jni/arch-x86/android_memset16.S libcutils/jni/arch-x86/android_memset32.S libcutils/jni/memory.c
else # !x86-atom
libcutils_SRC_FILES += libcutils/jni/memory.c
endif # !x86-atom
endif # !sh
endif # !arm

ifeq ($(TARGET_CPU_SMP),true)
    libcutils_targetSmpFlag := -DANDROID_SMP=1
else
    libcutils_targetSmpFlag := -DANDROID_SMP=0
endif

libcutils_CFLAGS += $(libcutils_targetSmpFlag)
libcutils_CFLAGS += -DHAVE_PTHREADS -DHAVE_SCHED_H -DHAVE_SYS_UIO_H -DHAVE_ANDROID_OS -DHAVE_IOCTL -DHAVE_TM_GMTOFF
libcutils_C_INCLUDES := $(LOCAL_PATH)/libcutils/jni/include
	
#############################################################################
# libhost definitions
#############################################################################
libhost_SRC_FILES:= \
	libhost/jni/CopyFile.c \
	libhost/jni/pseudolocalize.cpp

ifeq ($(HOST_OS),cygwin)
libhost_CFLAGS += -DWIN32_EXE
endif
ifeq ($(HOST_OS),windows)
  ifeq ($(USE_MINGW),)
    # Case where we're building windows but not under linux (so it must be cygwin)
    libhost_CFLAGS += -DUSE_MINGW
  endif
endif
ifeq ($(HOST_OS),darwin)
libhost_CFLAGS += -DMACOSX_RSRC
endif

libhost_C_INCLUDES := $(LOCAL_PATH)/libhost/jni/include

#############################################################################
# libutils definitions
#############################################################################
libutils_SRC_FILES := \
	libutils/jni/CallStack.cpp \
	libutils/jni/FileMap.cpp \
	libutils/jni/JenkinsHash.cpp \
	libutils/jni/LinearTransform.cpp \
	libutils/jni/Printer.cpp \
	libutils/jni/PropertyMap.cpp \
	libutils/jni/RefBase.cpp \
	libutils/jni/SharedBuffer.cpp \
	libutils/jni/Static.cpp \
	libutils/jni/StopWatch.cpp \
	libutils/jni/String8.cpp \
	libutils/jni/String16.cpp \
	libutils/jni/StrongPointer.cpp \
	libutils/jni/SystemClock.cpp \
	libutils/jni/Threads.cpp \
	libutils/jni/Timers.cpp \
	libutils/jni/Tokenizer.cpp \
	libutils/jni/Unicode.cpp \
	libutils/jni/VectorImpl.cpp \
	libutils/jni/misc.cpp \
	libutils/jni/BlobCache.cpp \
    libutils/jni/Looper.cpp \
	libutils/jni/ProcessCallStack.cpp \
	libutils/jni/Trace.cpp \
	libutils/jni/safe_iop.cpp

libutils_CFLAGS += -DHAVE_ENDIAN_H -DHAVE_ANDROID_OS -DHAVE_PTHREADS -DHAVE_SYS_UIO_H -DHAVE_POSIX_FILEMAP
libutils_C_INCLUDES += $(LOCAL_PATH)/libutils/jni/include

#############################################################################
# libsystem definitions
#############################################################################
libsystem_C_INCLUDES := $(LOCAL_PATH)/libsystem/include


#############################################################################
# androidfw definitions
#############################################################################

androidfw_SRC_FILES := \
    androidfw/jni/Asset.cpp \
    androidfw/jni/AssetDir.cpp \
    androidfw/jni/AssetManager.cpp \
    androidfw/jni/LocaleData.cpp \
    androidfw/jni/misc.cpp \
    androidfw/jni/ObbFile.cpp \
    androidfw/jni/ResourceTypes.cpp" \
    androidfw/jni/StreamingZipInflater.cpp \
    androidfw/jni/TypeWrappers.cpp \
    androidfw/jni/ZipFileRO.cpp \
    androidfw/jni/ZipUtils.cpp \
    androidfw/jni/BackupData.cpp \
    androidfw/jni/BackupHelpers.cpp \
    androidfw/jni/CursorWindow.cpp \
    androidfw/jni/DisplayEventDispatcher.cpp \

androidfw_C_INCLUDES := $(LOCAL_PATH)/androidfw/jni/include

#############################################################################
# libbacktrace definitions
#############################################################################
libbacktrace_SRC_FILES := \
    libbacktrace/Backtrace.cpp \
    libbacktrace/BacktraceCurrent.cpp \
    libbacktrace/BacktracePtrace.cpp \
    libbacktrace/thread_utils.c \
    libbacktrace/ThreadEntry.cpp \
    libbacktrace/UnwindCurrent.cpp \
    libbacktrace/UnwindMap.cpp \
    libbacktrace/UnwindPtrace.cpp \
    libbacktrace/UnwindStack.cpp \
    libbacktrace/UnwindStackMap.cpp \

libbacktrace_C_INCLUDES := $(LOCAL_PATH)/libbacktrace/include

#############################################################################
# libziparchive definitions
#############################################################################
libziparchive_SRC_FILES := \
    libziparchive/zip_archive.cc \
    libziparchive/zip_archive_stream_entry.cc \
    libziparchive/zip_writer.cc

libziparchive_C_INCLUDES := $(LOCAL_PATH)/libziparchive/include

#############################################################################
# base definitions
#############################################################################
base_SRC_FILES := \
    base/file.cpp \
    base/logging.cpp \
    base/parsenetaddress.cpp \
    base/quick_exit.cpp \
    base/stringprintf.cpp \
    base/strings.cpp

base_C_INCLUDES := $(LOCAL_PATH)/include/include

#############################################################################
# aapt definitions
#############################################################################
aapt_SRC_FILES := \
  JNImain.c 	\
	aapt/jni/AaptAssets.cpp \
    aapt/jni/AaptConfig.cpp \
    aapt/jni/AaptUtil.cpp \
	aapt/jni/AaptXml.cpp \
    aapt/jni/ApkBuilder.cpp \
	aapt/jni/Command.cpp \
	aapt/jni/CrunchCache.cpp \
	aapt/jni/FileFinder.cpp \
	aapt/jni/Images.cpp \
	aapt/jni/Package.cpp \
	aapt/jni/pseudolocalize.cpp \
	aapt/jni/Resource.cpp \
	aapt/jni/ResourceFilter.cpp \
	aapt/jni/ResourceIdCache.cpp \
	aapt/jni/ResourceTable.cpp \
	aapt/jni/SourcePos.cpp \
	aapt/jni/StringPool.cpp \
	aapt/jni/WorkQueue.cpp \
	aapt/jni/XMLNode.cpp \
	aapt/jni/ZipEntry.cpp \
	aapt/jni/ZipFile.cpp

aapt_CFLAGS += -Wno-format-y2k

#############################################################################
# put it all together
#############################################################################
include $(CLEAR_VARS)
LOCAL_MODULE:= libaaptcomplete

LOCAL_SRC_FILES += $(libpng_SRC_FILES)
LOCAL_SRC_FILES += $(expat_SRC_FILES)
LOCAL_SRC_FILES += $(liblog_SRC_FILES)
LOCAL_SRC_FILES += $(libcutils_SRC_FILES)
LOCAL_SRC_FILES += $(libhost_SRC_FILES)
LOCAL_SRC_FILES += $(libutils_SRC_FILES)
LOCAL_SRC_FILES += $(androidfw_SRC_FILES)
LOCAL_SRC_FILES += $(libbacktrace_SRC_FILES)
LOCAL_SRC_FILES += $(libziparchive_SRC_FILES)
LOCAL_SRC_FILES += $(aapt_SRC_FILES)
LOCAL_SRC_FILES += $(base_SRC_FILES)

LOCAL_C_INCLUDES += $(libpng_C_INCLUDES)
LOCAL_C_INCLUDES += $(expat_C_INCLUDES)
#LOCAL_C_INCLUDES += $(liblog_C_INCLUDES)
LOCAL_C_INCLUDES += $(libcutils_C_INCLUDES)
LOCAL_C_INCLUDES += $(libhost_C_INCLUDES)
LOCAL_C_INCLUDES += $(libutils_C_INCLUDES)
LOCAL_C_INCLUDES += $(androidfw_C_INCLUDES)
LOCAL_C_INCLUDES += $(libbacktrace_C_INCLUDES)
LOCAL_C_INCLUDES += $(libsystem_C_INCLUDES)
LOCAL_C_INCLUDES += $(libziparchive_C_INCLUDES)
LOCAL_C_INCLUDES += $(base_C_INCLUDES)

LOCAL_CFLAGS += $(expat_CFLAGS)
LOCAL_CFLAGS += $(liblog_CFLAGS)
LOCAL_CFLAGS += $(libcutils_CFLAGS)
LOCAL_CFLAGS += $(libhost_CFLAGS)
LOCAL_CFLAGS += $(libutils_CFLAGS)
LOCAL_CFLAGS += $(aapt_CFLAGS)

LOCAL_LDLIBS += -lz -llog

# Building a commandline executable for Android
# include $(BUILD_EXECUTABLE)

# Building a shared library for Android
include $(BUILD_SHARED_LIBRARY)
