FROM greyltc/archlinux

RUN pacman -Syyu --noconfirm --needed libotr purple-facebook purple-skypeweb git base-devel

WORKDIR /var/lib/bitlbee/

RUN git clone https://aur.archlinux.org/bitlbee-libpurple.git bitlbee-libpurple \
    && chmod -R 777 bitlbee-libpurple \
    && echo "ALL ALL=(ALL) NOPASSWD: /usr/bin/pacman" >> /etc/sudoers

WORKDIR ./bitlbee-libpurple
RUN useradd -M -N build
USER build 
RUN makepkg --noprogressbar --nosign --syncdeps --noconfirm --force --install

WORKDIR /var/lib/bitlbee
USER root
RUN userdel -rf build && rm -rf bitlbee-libpurple 

RUN mkdir /var/lib/bitlbee/data/ \
    && ln -s /etc/bitlbee/ /var/lib/bitlbee/etc 

COPY bitlbee.conf /var/lib/bitlbee/etc/

COPY run.sh /var/lib/bitlbee/ 

RUN chown -R bitlbee:bitlbee /run/bitlbee/
RUN chown -R root:bitlbee /etc/bitlbee/
RUN chown -R bitlbee:bitlbee /var/lib/bitlbee/

VOLUME ["/var/lib/bitlbee/data"]

CMD ["/var/lib/bitlbee/run.sh"]

