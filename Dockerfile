FROM greyltc/archlinux-aur

RUN pacman -Syyu --noconfirm --needed \
    && pacman --noconfirm -S libotr purple-facebook purple-skypeweb \
    && su docker -c 'pacaur -S --noprogressbar --noedit --noconfirm bitlbee-libpurple'


RUN rm /usr/bin/sh && ln -s /usr/bin/bash /usr/bin/sh
RUN su docker -c 'pacaur -S --noprogressbar --noedit --noconfirm bitlbee-discord-git bitlbee-steam-git purple-rocketchat protobuf-c purple-hangouts-hg'
RUN pacman --noconfirm -Rns $(pacman -Qdtq) && pacman --noconfirm -Scc

WORKDIR /var/lib/bitlbee/

RUN mkdir /var/lib/bitlbee/data/ \
    && ln -s /etc/bitlbee/ /var/lib/bitlbee/etc 

COPY bitlbee.conf /var/lib/bitlbee/etc/

COPY run.sh /var/lib/bitlbee/ 

RUN chown -R bitlbee:bitlbee /run/bitlbee/ \
    && chown -R root:bitlbee /etc/bitlbee/ \
    && chown -R bitlbee:bitlbee /var/lib/bitlbee/

VOLUME ["/var/lib/bitlbee/data"]

CMD ["/var/lib/bitlbee/run.sh"]

