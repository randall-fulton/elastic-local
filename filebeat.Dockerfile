FROM docker.elastic.co/beats/filebeat:7.3.1

USER root

# RUN yum install -y docker

COPY filebeat.yml /usr/share/filebeat/template.yml
COPY docker-entrypoint.sh /usr/share/entrypoint.sh
RUN chown root /usr/share/filebeat/filebeat.yml /usr/share/entrypoint.sh

ENTRYPOINT ["/usr/share/entrypoint.sh"]
CMD ["start"]
