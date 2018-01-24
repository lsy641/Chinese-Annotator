#!/bin/bash

## lower version
 mongo chinese_annotator -eval "db.addUser({user:\"anno_admin\", pwd:\"123\", roles:[\"readWrite\", \"dbAdmin\"]})"
## newer version
# mongo chinese_annotator -eval "db.createUser({user:\"anno_admin\", pwd:\"123\", roles:[\"readWrite\", \"dbAdmin\"]})"

mongo chinese_annotator -eval "db.user.insert({_id: ObjectId(\"5a683cadfe61a3fe9262a310\"), user_name:\"booker\"})"
mongo chinese_annotator -eval "db.dataset.insert({_id:ObjectId(\"5a6840b28831a3e06abbbcc9\"), dataset_name: \"test\", user_uuid: \"5a683cadfe61a3fe9262a310\"})"
insert_neg_str="{text: \"我是个垃圾##！\", labeled: false, dataset_uuid: \"5a6840b28831a3e06abbbcc9\"}"
insert_pos_str="{text: \"我是荣耀王者##！\", labeled: false, dataset_uuid: \"5a6840b28831a3e06abbbcc9\"}"
max_sample=10
for i in $(seq 1 $max_sample)
do
    insert_str_new=`echo $insert_neg_str | sed -n "s/##/$i/"p`
    mongo chinese_annotator -eval "db.annotation_raw_data.insert($insert_str_new)"
    insert_str_new=`echo $insert_pos_str | sed -n "s/##/$i/"p`
    mongo chinese_annotator -eval "db.annotation_raw_data.insert($insert_str_new)"
done


