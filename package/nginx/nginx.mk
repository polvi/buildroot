################################################################################
#
# systemd
#
################################################################################

NGINX_VERSION = 1.5.2
NGINX_SITE = http://nginx.org/download/
NGINX_SOURCE = nginx-$(NGINX_VERSION).tar.gz

NGINX_CONF_OPT = \
	--with-cc-opt="-I$(STAGING_DIR)/usr/include" \
	--with-ld-opt="-L$(STAGING_DIR)/usr/lib" \
	--with-systemd \
	--with-ipv6


define NGINX_BUILD_CMDS
	cd $(@D) && ./configure $(NGINX_CONF_OPT)
	$(MAKE) LINK="$(CC) -L$(TARGET_LD)" -C $(@D)
endef

define NGINX_INSTALL_TARGET_CMDS
	cd $(@D) && DESTDIR=$(TARGET_DIR) $(MAKE) install
endef

$(eval $(generic-package))
