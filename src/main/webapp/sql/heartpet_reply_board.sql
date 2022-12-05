create table heartpet_reply_board (
    reply_board_replyno number(5) primary key,
    reply_board_boardno number(5),
    reply_board_category varchar2(20) not null,
    reply_board_id varchar2(1000),
    reply_board_hit number(5),
    reply_board_title varchar2(1000),
    reply_board_content varchar2(2000),
    reply_board_secret varchar2(1),
    reply_board_img1 varchar2(1000),
    reply_board_img2 varchar2(1000)
);

insert into heartpet_reply_board values(1, 1, '입양', 'user', 0, '게시판답글제목1', '게시판답글내용1', 'N');
insert into heartpet_reply_board values(2, 2, '입양', 'user1', 0, '게시판답글제목1', '게시판답글내용1', 'N');

commit;

drop table heartpet_reply_board purge;