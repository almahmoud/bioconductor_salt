{% set build = salt["pillar.get"]("build") %}
{% set machine = salt["pillar.get"]("machine") %}
{% if grains["os"] == "Windows" %}
{% set extension = "bat" %}
{% else %}
{% set extension = "sh" %}
{% endif %}

{%- for type in build.types %}
configure_{{ build.version }}_{{ type }}_BBS_OUTGOING_MAP:
  file.line:
    - name: /home/biocbuild/BBS/{{ build.version }}/{{ type }}/{{ machine.name }}/config.{{ extension }}
    - content: export BBS_OUTGOING_MAP="source:{{ machine.name }}/buildsrc"
    - match: BBS_OUTGOING_MAP
    - mode: replace
    - user: biocbuild
    - group: biocbuild

configure_{{ build.version }}_{{ type }}_BBS_REPORT_NODES:
  file.line:
    - name: /home/biocbuild/BBS/{{ build.version }}/{{ type }}/{{ machine.name }}/config.{{ extension }}
    - content: export BBS_REPORT_NODES="{{ machine.name }}"
    - match: BBS_REPORT_NODES
    - mode: replace
    - user: biocbuild
    - group: biocbuild

configure_{{ build.version }}_{{ type }}_BBS_NB_CPU:
  file.line:
    - name: /home/biocbuild/BBS/{{ build.version }}/{{ type }}/{{ machine.name }}/config.{{ extension }}
    - content: export BBS_NB_CPU={{ machine.cores }}
    - match: BBS_NB_CPU
    - mode: replace
    - user: biocbuild
    - group: biocbuild

configure_{{ build.version }}_{{ type }}_BBS_CHECK_NB_CPU:
  file.line:
    - name: /home/biocbuild/BBS/{{ build.version }}/{{ type }}/{{ machine.name }}/config.{{ extension }}
    - content: export BBS_CHECK_NB_CPU={{ machine.cores }}
    - match: BBS_CHECK_NB_CPU
    - mode: replace
    - user: biocbuild
    - group: biocbuild
{%- endfor %}
