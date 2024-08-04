


CREATE TABLE column_mapping(model_name VARCHAR, column_name VARCHAR, column_type VARCHAR, "comment" INTEGER, "index" BIGINT);
CREATE TABLE edges(parent_idx BIGINT, child_idx BIGINT);
CREATE TABLE nodes(model_name VARCHAR, "index" BIGINT);
CREATE TABLE sql_mapping(model_name VARCHAR, sql_text VARCHAR);
CREATE TABLE sql_tags(model_name VARCHAR, summary VARCHAR, tags JSON);
CREATE TABLE table_lineage(input_model VARCHAR, input_column VARCHAR, tags JSON, output_model VARCHAR, output_columns JSON);




