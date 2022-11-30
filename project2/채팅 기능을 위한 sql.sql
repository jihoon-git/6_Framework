-- 채팅
CREATE TABLE "CHATTING_ROOM" (
   "CHATTING_NO"   NUMBER      NOT NULL,
   "CH_CREATE_DATE"   DATE   DEFAULT SYSDATE   NOT NULL,
   "OPEN_MEMBER"   NUMBER      NOT NULL,
   "PARTICIPANT"   NUMBER      NOT NULL
);

COMMENT ON COLUMN "CHATTING_ROOM"."CHATTING_NO" IS '채팅방 번호';

COMMENT ON COLUMN "CHATTING_ROOM"."CH_CREATE_DATE" IS '채팅방 생성일';

COMMENT ON COLUMN "CHATTING_ROOM"."OPEN_MEMBER" IS '개설자 회원 번호';

COMMENT ON COLUMN "CHATTING_ROOM"."PARTICIPANT" IS '참여자 회원 번호';

ALTER TABLE "CHATTING_ROOM" ADD CONSTRAINT "PK_CHATTING_ROOM" PRIMARY KEY (
   "CHATTING_NO"
);

ALTER TABLE "CHATTING_ROOM" 
ADD CONSTRAINT "FK_OPEN_MEMBER" 
FOREIGN KEY ("OPEN_MEMBER") REFERENCES "MEMBER";

ALTER TABLE "CHATTING_ROOM" 
ADD CONSTRAINT "FK_PARTICIPANT" 
FOREIGN KEY ("PARTICIPANT") REFERENCES "MEMBER";


CREATE TABLE "MESSAGE" (
   "MESSAGE_NO"   NUMBER      NOT NULL,
   "MESSAGE_CONTENT"   VARCHAR2(4000)      NOT NULL,
   "READ_FL"   CHAR   DEFAULT 'N'   NOT NULL,
   "SEND_TIME"   DATE   DEFAULT SYSDATE   NOT NULL,
   "SENDER_NO"   NUMBER      NOT NULL,
   "CHATTING_NO"   NUMBER      NOT NULL
);

COMMENT ON COLUMN "MESSAGE"."MESSAGE_NO" IS '메세지 번호';

COMMENT ON COLUMN "MESSAGE"."MESSAGE_CONTENT" IS '메세지 내용';

COMMENT ON COLUMN "MESSAGE"."READ_FL" IS '읽음 여부';

COMMENT ON COLUMN "MESSAGE"."SEND_TIME" IS '메세지 보낸 시간';

COMMENT ON COLUMN "MESSAGE"."SENDER_NO" IS '보낸 회원의 번호';

COMMENT ON COLUMN "MESSAGE"."CHATTING_NO" IS '채팅방 번호';


ALTER TABLE "MESSAGE" ADD CONSTRAINT "PK_MESSAGE" PRIMARY KEY (
   "MESSAGE_NO"
);


ALTER TABLE "MESSAGE" 
ADD CONSTRAINT "FK_CHATTING_NO" 
FOREIGN KEY ("CHATTING_NO") REFERENCES "CHATTING_ROOM";

ALTER TABLE "MESSAGE" 
ADD CONSTRAINT "FK_SENDER_NO" 
FOREIGN KEY ("SENDER_NO") REFERENCES "MEMBER";

-- 시퀀스 생성
CREATE SEQUENCE SEQ_ROOM_NO NOCACHE;
CREATE SEQUENCE SEQ_MESSAGE_NO NOCACHE;


-- 채팅 확인
-- 빈칸이 아니라 null이 나오게 하기 위해 sum으로 감싼다
  SELECT NVL(SUM(CHATTING_NO),0) CHATTING_NO
  FROM CHATTING_ROOM
  WHERE (OPEN_MEMBER = 1 AND PARTICIPANT = 2)
  OR (OPEN_MEMBER = 2 AND PARTICIPANT = 1);
  
SELECT * FROM BOARD_IMG
WHERE IMG_ORDER = 0
ORDER BY BOARD_NO;

DELETE FROM BOARD_IMG
WHERE IMG_ORDER = 0;
 