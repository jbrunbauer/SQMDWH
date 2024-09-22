--liquibase formatted sql
--changeset jbr:202409220703 context:test labels:SQMDWH-XX
--comment Add column test to employees Table
ALTER TABLE HR.employees ADD ( test VARCHAR2(10) );
