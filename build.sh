#!/bin/bash
#
# Build server modules and copy them to autodeploy folder
#

mkdir -p localdata/{db,vault}
mkdir -p autodeploy/bundles
rm autodeploy/*

PLM_SOURCES=../docdoku-plm

mvn -f ${PLM_SOURCES}/pom.xml clean install

cp \
${PLM_SOURCES}/docdoku-server/docdoku-server-ear/target/docdoku-server-ear.ear \
${PLM_SOURCES}/converter-all/converter-all-ear/target/converter-all-ear-2.5-SNAPSHOT.ear \
${PLM_SOURCES}/converter-dae/converter-dae-ear/target/converter-dae-ear-2.5-SNAPSHOT.ear \
${PLM_SOURCES}/converter-ifc/converter-ifc-ear/target/converter-ifc-ear-2.5-SNAPSHOT.ear \
${PLM_SOURCES}/converter-obj/converter-obj-ear/target/converter-obj-ear-2.5-SNAPSHOT.ear \
${PLM_SOURCES}/converter-step/converter-step-ear/target/converter-step-ear-2.5-SNAPSHOT.ear \
./autodeploy

