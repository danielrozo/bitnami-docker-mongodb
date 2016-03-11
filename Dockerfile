FROM gcr.io/stacksmith-images/ubuntu:14.04
MAINTAINER Bitnami <containers@bitnami.com>

ENV BITNAMI_APP_NAME=mongodb \
    BITNAMI_APP_USER=mongo \
    BITNAMI_APP_VERSION=3.2.1-0 \
    MONGODB_PACKAGE_SHA256="cf0e248f090d4aa59520f7d2704c5813a57279f3b650c09e25281dcc1e986550"

ENV BITNAMI_APP_DIR=/opt/bitnami/$BITNAMI_APP_NAME \
    BITNAMI_APP_VOL_PREFIX=/bitnami/$BITNAMI_APP_NAME

ENV PATH=$BITNAMI_APP_DIR/bin:/opt/bitnami/common/bin:$PATH

RUN bitnami-pkg unpack $BITNAMI_APP_NAME-$BITNAMI_APP_VERSION

# these symlinks should be setup by harpoon at unpack
RUN mkdir -p $BITNAMI_APP_VOL_PREFIX && \
    ln -s $BITNAMI_APP_DIR/data $BITNAMI_APP_VOL_PREFIX/data && \
    ln -s $BITNAMI_APP_DIR/conf $BITNAMI_APP_VOL_PREFIX/conf && \
    ln -s $BITNAMI_APP_DIR/logs $BITNAMI_APP_VOL_PREFIX/logs

COPY rootfs/ /

EXPOSE 27017

VOLUME ["$BITNAMI_APP_VOL_PREFIX/data"]

ENTRYPOINT ["/entrypoint.sh"]
CMD ["harpoon", "start", "--foreground", "mongodb"]
