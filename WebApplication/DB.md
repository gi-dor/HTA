### ⛏ DB 테이블 생성 , 제약조건 , 시퀀스

#### 🔨 COMM_USERS 테이블

```sql
ALTER
SESSION SET "_ORACLE_SCRIPT" = TRUE;

CREATE
USER comm IDENTIFIED BY 비밀번호;

GRANT CONNECT , RESOURCE TO comm;



-- 사용자 정보를 저장하는 테이블

/*
사용자 번호 
사용자 아이디
사용자 비밀번호
사용자 이름
사용자 이메일
사용자 연락처
사용자 탈퇴여부
정보변경일자
등록일자
*/

CREATE TABLE COMM_USERS
(
    USER_NO           NUMBER(4),
    USER_ID           VARCHAR2(255) NOT NULL,
    USER_PASSWORD     VARCHAR2(255) NOT NULL,
    USER_NAME         VARCHAR2(255) NOT NULL,
    USER_EMAIL        VARCHAR2(255),
    USER_TEL          VARCHAR(255),
    USER_DELETED      CHAR(1) DEFAULT 'N',
    USER_UPDATED_DATE DATE    DEFAULT SYSDATE,
    USER_CREATED_DATE DATE    DEFAULT SYSDATE,

    CONSTRAINT USERS_NO_PK PRIMARY KEY (USER_NO),
    CONSTRAINT USER_ID_UK UNIQUE (USER_ID),
    CONSTRAINT ISER_EMAIL_UK UNIQUE (USER_EMAIL)
);


-- 사용자 번호용 시퀀스
CREATE SEQUENCE USERS_SEQ START WITH 1000 NOCACHE;
```

<br><Br>

#### ⚙ COMM_BOARDS , COMM_REPLIES 테이블

```sql
CREATE TABLE COMM_BOARDS
(
    BOARD_NO           NUMBER(6),
    BOARD_TITLE        VARCHAR2(255) NOT NULL,
    USER_NO            NUMBER(4) NOT NULL,
    BOARD_CONTENT      VARCHAR2(2000) NOT NULL,
    BOARD_REPLY_CNT    NUMBER(6) DEFAULT 0,
    BOARD_DELETED      CHAR(1) DEFAULT 'N',
    BOARD_UPDATED_DATE DATE    DEFAULT SYSDATE,
    BOARD_CREATED_DATE DATE    DEFAULT SYSDATE,

    CONSTRAINT BOARDS_NO_PK PRIMARY KEY (BOARD_NO),
    CONSTRAINT BOARDS_USERNO_FK FOREIGN KEY (USER_NO)
        REFERENCES COMM_USERS (USER_NO)
);

CREATE TABLE COMM_REPLIES
(
    REPLY_NO           NUMBER(6),
    USER_NO            NUMBER(4) NOT NULL,
    BOARD_NO           NUMBER(6) NOT NULL,
    REPLY_CONTENT      VARCHAR2(1000) NOT NULL,
    REPLY_DELETED      CHAR(1) DEFAULT 'N',
    REPLY_UPDATED_DATE DATE    DEFAULT SYSDATE,
    REPLY_CREATED_DATE DATE    DEFAULT SYSDATE,

    CONSTRAINT REPLIES_NO_PK PRIMARY KEY (REPLY_NO),
    CONSTRAINT REPLIES_USERNO_FK FOREIGN KEY (USER_NO)
        REFERENCES COMM_USERS (USER_NO),
    CONSTRAINT REPLIES_BOARDNO_FK FOREIGN KEY (BOARD_NO)
        REFERENCES COMM_BOARDS (BOARD_NO)
);
```

```sql
CREATE SEQUENCE BOARDS_SEQ START WITH 100000 NOCACHE;
CREATE SEQUENCE REPLIES_SEQ START WITH 100000 NOCACHE;
```

<br><Br>

#### 🔧 COMM_TODO_CATEGORIES , COMM_TODOS 테이블

```sql
/**
   일정 관리 관련테이블

  1. 일정 종류

  2. 일정 데이터
 */

CREATE TABLE COMM_TODO_CATEGORIES
(
    CATEGORY_NO   NUMBER(3),
    CATEGORY_NAME VARCHAR2(255) NOT NULL,

    CONSTRAINT TODO_CATNO_PK PRIMARY KEY (CATEGORY_NO)
);

CREATE TABLE COMM_TODOS
(
    TODO_NO            NUMBER(6),
    CATEGORY_NO        NUMBER(3) NOT NULL,
    TODO_TITLE         VARCHAR2(255) NOT NULL,
    USER_NO            NUMBER(4) NOT NULL,
    TODO_EXPECTED_DATE CHAR(10) NOT NULL,
    TODO_CONTENT       VARCHAR2(2000) NOT NULL,
    TODO_STATUS        VARCHAR2(255) DEFAULT '처리예정',
    TODO_DELETED       CHAR(1) DEFAULT 'N',
    TODO_UPDATED_DATE  DATE    DEFAULT SYSDATE,
    TODO_CREATED_DATE  DATE    DEFAULT SYSDATE,

    CONSTRAINT TODO_NO_PK PRIMARY KEY (TODO_NO),
    CONSTRAINT TODO_CATEGORYNO_FK FOREIGN KEY (CATEGORY_NO)
        REFERENCES COMM_TODO_CATEGORIES (CATEGORY_NO),
    CONSTRAINT TODO_USERNO_FK FOREIGN KEY (USER_NO)
        REFERENCES COMM_USERS (USER_NO),
    CONSTRAINT TODO_STATUS_CK CHECK ( TODO_STATUS IN ('처리예정', '처리완료', '취소') )

);

CREATE SEQUENCE TODOS_SEQ START WITH 100000 NOCACHE;
```

```sql
INSERT INTO COMM_TODO_CATEGORIES
VALUES (101, '회의');
INSERT INTO COMM_TODO_CATEGORIES
VALUES (102, '출장');
INSERT INTO COMM_TODO_CATEGORIES
VALUES (103, '휴가');
INSERT INTO COMM_TODO_CATEGORIES
VALUES (104, '개발');
INSERT INTO COMM_TODO_CATEGORIES
VALUES (105, '테스트');
INSERT INTO COMM_TODO_CATEGORIES
VALUES (106, '배포');
INSERT INTO COMM_TODO_CATEGORIES
VALUES (107, '교육');
INSERT INTO COMM_TODO_CATEGORIES
VALUES (108, '외근');
INSERT INTO COMM_TODO_CATEGORIES
VALUES (109, '외부회의');
INSERT INTO COMM_TODO_CATEGORIES
VALUES (110, '기타');
COMMIT;

```

게시판 , 댓글

```sql
CREATE TABLE COMM_BOARDS
(
    BOARD_NO           NUMBER(6),
    BOARD_TITLE        VARCHAR2(255) NOT NULL,
    USER_NO            NUMBER(4) NOT NULL,
    BOARD_CONTENT      VARCHAR2(2000) NOT NULL,
    BOARD_REPLY_CNT    NUMBER(6) DEFAULT 0,
    BOARD_DELETED      CHAR(1) DEFAULT 'N',
    BOARD_UPDATED_DATE DATE    DEFAULT SYSDATE,
    BOARD_CREATED_DATE DATE    DEFAULT SYSDATE,

    CONSTRAINT BOARDS_NO_PK PRIMARY KEY (BOARD_NO),
    CONSTRAINT BOARDS_USERNO_FK FOREIGN KEY (USER_NO)
        REFERENCES COMM_USERS (USER_NO)
);

CREATE TABLE COMM_REPLIES
(
    REPLY_NO           NUMBER(6),
    USER_NO            NUMBER(4) NOT NULL,
    BOARD_NO           NUMBER(6) NOT NULL,
    REPLY_CONTENT      VARCHAR2(1000) NOT NULL,
    REPLY_DELETED      CHAR(1) DEFAULT 'N',
    REPLY_UPDATED_DATE DATE    DEFAULT SYSDATE,
    REPLY_CREATED_DATE DATE    DEFAULT SYSDATE,

    CONSTRAINT REPLIES_NO_PK PRIMARY KEY (REPLY_NO),
    CONSTRAINT REPLIES_USERNO_FK FOREIGN KEY (USER_NO)
        REFERENCES COMM_USERS (USER_NO),
    CONSTRAINT REPLIES_BOARDNO_FK FOREIGN KEY (BOARD_NO)
        REFERENCES COMM_BOARDS (BOARD_NO)
);
```

첨부파일

```sql

CREATE TABLE COMM_FILE_BOARDS
(
    FILE_BOARD_NO           NUMBER(6),
    FILE_BOARD_TITLE        VARCHAR2(255) NOT NULL,
    FILE_BOARD_DESCRIPTION  VARCHAR2(2000) NOT NULL,
    FILE_BOARD_DELETED      CHAR(1) DEFAULT 'N',
    USER_NO                 NUMBER(4) NOT NULL,
    FILE_BOARD_FILE_NAME    VARCHAR2(255) NOT NULL,
    FILE_BOARD_FILE_SIZE    NUMBER,
    FILE_BOARD_UPDATED_DATE DATE    DEFAULT SYSDATE,
    FILE_BOARD_CREATED_DATE DATE    DEFAULT SYSDATE,

    CONSTRAINT FILE_BOARDNO_PK PRIMARY KEY (FILE_BOARD_NO),
    CONSTRAINT FILE_USERNO_FK FOREIGN KEY (USER_NO)
        REFERENCES COMM_USERS (USER_NO)
);

alter table COMM_FILE_BOARDS
    add constraint FILE_BOARDNO_PK primary key (file_board_no);

alter table COMM_FILE_BOARDS
    add constraint FILE_USERNO_FK foreign key (USER_NO) references comm_users (user_no);


```

상품

```sql
CREATE TABLE COMM_PRODUCT_CATEGORIES
(
    category_no   number(4),
    category_name varchar2(255) not null,
    constraint product_catno_pk primary key (category_no)


);

create table comm_product_companies
(
    company_no   number(4),
    company_name varchar2(255) not null,
    company_tel  varchar2(255) not null,
    company_city varchar2(255) not null,

    constraint product_companyno_pk primary key (company_no)
);

create table comm_events
(
    event_no          number(4),
    event_title       varchar2(255) not null,
    event_description varchar2(255) not null,

    constraint eventno_pk primary key (event_no)
);

create table comm_product_status
(
    status_no   number(4),
    status_name varchar2(255) not null,

    constraint product_statusno_pk primary key (status_no)
);


create table comm_products
(
    product_no             number(6),
    product_name           varchar2(255) not null,
    category_no            number(4) not null,
    company_no             number(4) not null,
    product_price          number(8) not null,
    product_discount_price number(8) not null,
    product_description    varchar2(1000) not null,
    status_no              number(4) not null,
    product_stock          number(5) default 100,
    product_updated_date   date default sysdate,
    product_created_date   date default sysdate,

    constraint productno_pk primary key (product_no),
    constraint product_catno_fk foreign key (category_no)
        references COMM_PRODUCT_CATEGORIES (category_no),
    constraint product_companyno_fk foreign key (company_no)
        references comm_product_companies (company_no),
    constraint product_statusno_fk foreign key (status_no)
        references comm_product_status (status_no)

);



create table comm_product_events
(
    product_no number(6) not null,
    event_no   number(4) not null,

    constraint events_productno_fk foreign key (product_no)
        references comm_products (product_no),
    constraint events_eventno_fk foreign key (event_no)
        references comm_events (event_no)

);


create sequence products_seq start with 100000 nocache;
```

