PGDMP     /                    x            Course_Platform    9.6.14    9.6.14 G    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false            �           1262    16398    Course_Platform    DATABASE     �   CREATE DATABASE "Course_Platform" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'English_India.1252' LC_CTYPE = 'English_India.1252';
 !   DROP DATABASE "Course_Platform";
             postgres    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
             postgres    false            �           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                  postgres    false    3                        3079    12387    plpgsql 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;
    DROP EXTENSION plpgsql;
                  false            �           0    0    EXTENSION plpgsql    COMMENT     @   COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';
                       false    1            �            1255    24607    trig_discuss_advisor()    FUNCTION        CREATE FUNCTION public.trig_discuss_advisor() RETURNS trigger
    LANGUAGE plpgsql
    AS $$begin
	if new."IID" <> (select "IID" from public."Advisor" where public."Advisor"."AID"=new."AID") then
		raise exception 'A advisor can belong to only 1 institute';
	end if;
	return null;
end$$;
 -   DROP FUNCTION public.trig_discuss_advisor();
       public       postgres    false    3    1            �            1255    24605    trigger_course_unique_tutor()    FUNCTION     !  CREATE FUNCTION public.trigger_course_unique_tutor() RETURNS trigger
    LANGUAGE plpgsql
    AS $$begin
	if new."IID" <> (select "IID" from public."Tutor" where public."Tutor"."TID"=new."TID") then
		raise exception 'A tutor can belong to only 1 institute';
	end if;
	return null;
end$$;
 4   DROP FUNCTION public.trigger_course_unique_tutor();
       public       postgres    false    3    1            �            1255    16627    trigger_garde_func()    FUNCTION     D  CREATE FUNCTION public.trigger_garde_func() RETURNS trigger
    LANGUAGE plpgsql IMMUTABLE
    AS $$begin
	if new."Progress_report"< 0 or new."Progress_report" > (select max_credits from public."Course" where public."Course"."Course_id"=new."Course_id") then
		raise exception 'Invalid grade';
	end if;
	return null;
end$$;
 +   DROP FUNCTION public.trigger_garde_func();
       public       postgres    false    3    1            �            1255    16645    trigger_takes_func()    FUNCTION     ]  CREATE FUNCTION public.trigger_takes_func() RETURNS trigger
    LANGUAGE plpgsql LEAKPROOF
    AS $$begin
	if new."credit_score"<0 or new."credit_score">(select "max_credit" from public."Mock_test" where public."Mock_test"."Test_ID"=new."Test_ID") then
		raise exception 'Not a valid score';
	end if;
	return null;											   
end												 $$;
 +   DROP FUNCTION public.trigger_takes_func();
       public       postgres    false    3    1            �            1259    16484    Advisor    TABLE       CREATE TABLE public."Advisor" (
    "AID" character varying(25) NOT NULL,
    phone_no character(10) NOT NULL,
    name character varying(100) NOT NULL,
    "IID" character varying(25) NOT NULL,
    CONSTRAINT advisor_check CHECK ((length(phone_no) = 10))
);
    DROP TABLE public."Advisor";
       public         postgres    false    3            �            1259    16497    Course    TABLE     D  CREATE TABLE public."Course" (
    "Course_id" character varying(25) NOT NULL,
    course_title character varying(100) NOT NULL,
    max_credits integer,
    duration double precision NOT NULL,
    content character varying(50) NOT NULL,
    "IID" character varying(25) NOT NULL,
    "TID" character varying(25) NOT NULL
);
    DROP TABLE public."Course";
       public         postgres    false    3            �            1259    16571    Discussion_forum    TABLE     �   CREATE TABLE public."Discussion_forum" (
    "DID" character varying(25) NOT NULL,
    "Course_id" character varying(25) NOT NULL
);
 &   DROP TABLE public."Discussion_forum";
       public         postgres    false    3            �            1259    16606    Enrolls    TABLE     �   CREATE TABLE public."Enrolls" (
    "Course_id" character varying(25) NOT NULL,
    "EID" character varying(25) NOT NULL,
    "Progress_report" integer,
    start_date date NOT NULL
);
    DROP TABLE public."Enrolls";
       public         postgres    false    3            �            1259    16445 	   Institute    TABLE     �   CREATE TABLE public."Institute" (
    "IID" character varying(25) NOT NULL,
    name character varying(100) NOT NULL,
    mail character varying(50) NOT NULL
);
    DROP TABLE public."Institute";
       public         postgres    false    3            �            1259    16452    Institute_Phone_no    TABLE     �   CREATE TABLE public."Institute_Phone_no" (
    "IID" character varying(25) NOT NULL,
    phone_no character(10) NOT NULL,
    CONSTRAINT chk1_phone CHECK ((length(phone_no) = 10))
);
 (   DROP TABLE public."Institute_Phone_no";
       public         postgres    false    3            �            1259    16596 	   Mock_test    TABLE     �   CREATE TABLE public."Mock_test" (
    "Test_ID" character varying(25) NOT NULL,
    max_credit integer NOT NULL,
    "Course_id" character varying(25) NOT NULL
);
    DROP TABLE public."Mock_test";
       public         postgres    false    3            �            1259    16581    Participates    TABLE     �   CREATE TABLE public."Participates" (
    "EID" character varying(25) NOT NULL,
    "Course_id" character varying(25) NOT NULL
);
 "   DROP TABLE public."Participates";
       public         postgres    false    3            �            1259    16536    Prerequisite     TABLE     �   CREATE TABLE public."Prerequisite " (
    course_id_1 character varying(25) NOT NULL,
    prerequisite_course_id_2 character varying(25) NOT NULL,
    CONSTRAINT chk_1 CHECK (((course_id_1)::text <> (prerequisite_course_id_2)::text))
);
 #   DROP TABLE public."Prerequisite ";
       public         postgres    false    3            �            1259    16552    Student    TABLE     �   CREATE TABLE public."Student" (
    "EID" character varying(25) NOT NULL,
    name character varying(100) NOT NULL,
    mail character varying(50) NOT NULL,
    occupation character varying(50)
);
    DROP TABLE public."Student";
       public         postgres    false    3            �            1259    16630    Takes    TABLE     �   CREATE TABLE public."Takes" (
    "Test_ID" character varying(25) NOT NULL,
    "EID" character varying(25) NOT NULL,
    credit_score integer NOT NULL
);
    DROP TABLE public."Takes";
       public         postgres    false    3            �            1259    16471    Tutor    TABLE       CREATE TABLE public."Tutor" (
    "TID" character varying(25) NOT NULL,
    phone_no character(10) NOT NULL,
    name character varying(100) NOT NULL,
    "IID" character varying(25) NOT NULL,
    CONSTRAINT "Tutor_phone_no" CHECK ((length(phone_no) = 10))
);
    DROP TABLE public."Tutor";
       public         postgres    false    3            �          0    16484    Advisor 
   TABLE DATA               A   COPY public."Advisor" ("AID", phone_no, name, "IID") FROM stdin;
    public       postgres    false    188   UZ       �          0    16497    Course 
   TABLE DATA               k   COPY public."Course" ("Course_id", course_title, max_credits, duration, content, "IID", "TID") FROM stdin;
    public       postgres    false    189   �Z       �          0    16571    Discussion_forum 
   TABLE DATA               @   COPY public."Discussion_forum" ("DID", "Course_id") FROM stdin;
    public       postgres    false    192   �Z       �          0    16606    Enrolls 
   TABLE DATA               V   COPY public."Enrolls" ("Course_id", "EID", "Progress_report", start_date) FROM stdin;
    public       postgres    false    195   �Z       �          0    16445 	   Institute 
   TABLE DATA               8   COPY public."Institute" ("IID", name, mail) FROM stdin;
    public       postgres    false    185   [       �          0    16452    Institute_Phone_no 
   TABLE DATA               ?   COPY public."Institute_Phone_no" ("IID", phone_no) FROM stdin;
    public       postgres    false    186   _[       �          0    16596 	   Mock_test 
   TABLE DATA               I   COPY public."Mock_test" ("Test_ID", max_credit, "Course_id") FROM stdin;
    public       postgres    false    194   �[       �          0    16581    Participates 
   TABLE DATA               <   COPY public."Participates" ("EID", "Course_id") FROM stdin;
    public       postgres    false    193   �[       �          0    16536    Prerequisite  
   TABLE DATA               P   COPY public."Prerequisite " (course_id_1, prerequisite_course_id_2) FROM stdin;
    public       postgres    false    190   �[       �          0    16552    Student 
   TABLE DATA               B   COPY public."Student" ("EID", name, mail, occupation) FROM stdin;
    public       postgres    false    191   \       �          0    16630    Takes 
   TABLE DATA               A   COPY public."Takes" ("Test_ID", "EID", credit_score) FROM stdin;
    public       postgres    false    196   V\       �          0    16471    Tutor 
   TABLE DATA               ?   COPY public."Tutor" ("TID", phone_no, name, "IID") FROM stdin;
    public       postgres    false    187   ~\                  2606    16489    Advisor Advisor_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public."Advisor"
    ADD CONSTRAINT "Advisor_pkey" PRIMARY KEY ("AID");
 B   ALTER TABLE ONLY public."Advisor" DROP CONSTRAINT "Advisor_pkey";
       public         postgres    false    188    188                       2606    16504    Course Course_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public."Course"
    ADD CONSTRAINT "Course_pkey" PRIMARY KEY ("Course_id");
 @   ALTER TABLE ONLY public."Course" DROP CONSTRAINT "Course_pkey";
       public         postgres    false    189    189                       2606    16575 &   Discussion_forum Discussion_forum_pkey 
   CONSTRAINT     x   ALTER TABLE ONLY public."Discussion_forum"
    ADD CONSTRAINT "Discussion_forum_pkey" PRIMARY KEY ("DID", "Course_id");
 T   ALTER TABLE ONLY public."Discussion_forum" DROP CONSTRAINT "Discussion_forum_pkey";
       public         postgres    false    192    192    192            "           2606    16610    Enrolls Enrolls_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public."Enrolls"
    ADD CONSTRAINT "Enrolls_pkey" PRIMARY KEY ("Course_id", "EID");
 B   ALTER TABLE ONLY public."Enrolls" DROP CONSTRAINT "Enrolls_pkey";
       public         postgres    false    195    195    195                       2606    16457 *   Institute_Phone_no Institute_Phone_no_pkey 
   CONSTRAINT     y   ALTER TABLE ONLY public."Institute_Phone_no"
    ADD CONSTRAINT "Institute_Phone_no_pkey" PRIMARY KEY ("IID", phone_no);
 X   ALTER TABLE ONLY public."Institute_Phone_no" DROP CONSTRAINT "Institute_Phone_no_pkey";
       public         postgres    false    186    186    186                       2606    16449    Institute Institute_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public."Institute"
    ADD CONSTRAINT "Institute_pkey" PRIMARY KEY ("IID");
 F   ALTER TABLE ONLY public."Institute" DROP CONSTRAINT "Institute_pkey";
       public         postgres    false    185    185                        2606    16600    Mock_test Mock_test_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY public."Mock_test"
    ADD CONSTRAINT "Mock_test_pkey" PRIMARY KEY ("Test_ID");
 F   ALTER TABLE ONLY public."Mock_test" DROP CONSTRAINT "Mock_test_pkey";
       public         postgres    false    194    194                       2606    16585    Participates Participates_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY public."Participates"
    ADD CONSTRAINT "Participates_pkey" PRIMARY KEY ("EID", "Course_id");
 L   ALTER TABLE ONLY public."Participates" DROP CONSTRAINT "Participates_pkey";
       public         postgres    false    193    193    193                       2606    16541     Prerequisite  Prerequisite _pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public."Prerequisite "
    ADD CONSTRAINT "Prerequisite _pkey" PRIMARY KEY (course_id_1, prerequisite_course_id_2);
 N   ALTER TABLE ONLY public."Prerequisite " DROP CONSTRAINT "Prerequisite _pkey";
       public         postgres    false    190    190    190                       2606    16556    Student Student_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public."Student"
    ADD CONSTRAINT "Student_pkey" PRIMARY KEY ("EID");
 B   ALTER TABLE ONLY public."Student" DROP CONSTRAINT "Student_pkey";
       public         postgres    false    191    191            $           2606    16634    Takes Takes_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public."Takes"
    ADD CONSTRAINT "Takes_pkey" PRIMARY KEY ("Test_ID", "EID");
 >   ALTER TABLE ONLY public."Takes" DROP CONSTRAINT "Takes_pkey";
       public         postgres    false    196    196    196                       2606    16476    Tutor Tutor_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY public."Tutor"
    ADD CONSTRAINT "Tutor_pkey" PRIMARY KEY ("TID");
 >   ALTER TABLE ONLY public."Tutor" DROP CONSTRAINT "Tutor_pkey";
       public         postgres    false    187    187                       2606    16451    Institute institute_unique 
   CONSTRAINT     ]   ALTER TABLE ONLY public."Institute"
    ADD CONSTRAINT institute_unique UNIQUE (name, mail);
 F   ALTER TABLE ONLY public."Institute" DROP CONSTRAINT institute_unique;
       public         postgres    false    185    185    185                       2606    16491    Advisor phone_no_advisor 
   CONSTRAINT     Y   ALTER TABLE ONLY public."Advisor"
    ADD CONSTRAINT phone_no_advisor UNIQUE (phone_no);
 D   ALTER TABLE ONLY public."Advisor" DROP CONSTRAINT phone_no_advisor;
       public         postgres    false    188    188            
           2606    16459    Institute_Phone_no phone_unique 
   CONSTRAINT     `   ALTER TABLE ONLY public."Institute_Phone_no"
    ADD CONSTRAINT phone_unique UNIQUE (phone_no);
 K   ALTER TABLE ONLY public."Institute_Phone_no" DROP CONSTRAINT phone_unique;
       public         postgres    false    186    186                       2606    16478    Tutor phone_unique_tutor 
   CONSTRAINT     Y   ALTER TABLE ONLY public."Tutor"
    ADD CONSTRAINT phone_unique_tutor UNIQUE (phone_no);
 D   ALTER TABLE ONLY public."Tutor" DROP CONSTRAINT phone_unique_tutor;
       public         postgres    false    187    187                       2606    16558    Student uni_1 
   CONSTRAINT     J   ALTER TABLE ONLY public."Student"
    ADD CONSTRAINT uni_1 UNIQUE (mail);
 9   ALTER TABLE ONLY public."Student" DROP CONSTRAINT uni_1;
       public         postgres    false    191    191            4           2620    24606    Course trig_course_tutor    TRIGGER     �   CREATE TRIGGER trig_course_tutor BEFORE INSERT OR UPDATE ON public."Course" FOR EACH ROW EXECUTE PROCEDURE public.trigger_course_unique_tutor();
 3   DROP TRIGGER trig_course_tutor ON public."Course";
       public       postgres    false    189    211            5           2620    16629    Enrolls trigger_grade    TRIGGER     �   CREATE CONSTRAINT TRIGGER trigger_grade AFTER INSERT OR UPDATE OF "Progress_report" ON public."Enrolls" NOT DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE PROCEDURE public.trigger_garde_func();
 0   DROP TRIGGER trigger_grade ON public."Enrolls";
       public       postgres    false    195    209    195            6           2620    16647    Takes trigger_takes    TRIGGER     �   CREATE CONSTRAINT TRIGGER trigger_takes AFTER INSERT OR UPDATE OF credit_score ON public."Takes" NOT DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE PROCEDURE public.trigger_takes_func();
 .   DROP TRIGGER trigger_takes ON public."Takes";
       public       postgres    false    210    196    196            &           2606    16479    Tutor Tutor_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public."Tutor"
    ADD CONSTRAINT "Tutor_fk" FOREIGN KEY ("IID") REFERENCES public."Institute"("IID") ON UPDATE CASCADE ON DELETE CASCADE;
 <   ALTER TABLE ONLY public."Tutor" DROP CONSTRAINT "Tutor_fk";
       public       postgres    false    185    187    2052            '           2606    16492    Advisor advisor_iid    FK CONSTRAINT     �   ALTER TABLE ONLY public."Advisor"
    ADD CONSTRAINT advisor_iid FOREIGN KEY ("IID") REFERENCES public."Institute"("IID") ON UPDATE CASCADE ON DELETE CASCADE;
 ?   ALTER TABLE ONLY public."Advisor" DROP CONSTRAINT advisor_iid;
       public       postgres    false    188    2052    185            ,           2606    16576    Discussion_forum discuss_forum    FK CONSTRAINT     �   ALTER TABLE ONLY public."Discussion_forum"
    ADD CONSTRAINT discuss_forum FOREIGN KEY ("Course_id") REFERENCES public."Course"("Course_id") ON UPDATE CASCADE ON DELETE CASCADE;
 J   ALTER TABLE ONLY public."Discussion_forum" DROP CONSTRAINT discuss_forum;
       public       postgres    false    189    2068    192            (           2606    16505 
   Course fk1    FK CONSTRAINT     �   ALTER TABLE ONLY public."Course"
    ADD CONSTRAINT fk1 FOREIGN KEY ("IID") REFERENCES public."Institute"("IID") ON UPDATE CASCADE ON DELETE CASCADE;
 6   ALTER TABLE ONLY public."Course" DROP CONSTRAINT fk1;
       public       postgres    false    185    189    2052            *           2606    16542    Prerequisite  fk1_p    FK CONSTRAINT     �   ALTER TABLE ONLY public."Prerequisite "
    ADD CONSTRAINT fk1_p FOREIGN KEY (course_id_1) REFERENCES public."Course"("Course_id") ON UPDATE CASCADE ON DELETE CASCADE;
 ?   ALTER TABLE ONLY public."Prerequisite " DROP CONSTRAINT fk1_p;
       public       postgres    false    189    190    2068            )           2606    16510 
   Course fk2    FK CONSTRAINT     �   ALTER TABLE ONLY public."Course"
    ADD CONSTRAINT fk2 FOREIGN KEY ("TID") REFERENCES public."Tutor"("TID") ON UPDATE CASCADE ON DELETE CASCADE;
 6   ALTER TABLE ONLY public."Course" DROP CONSTRAINT fk2;
       public       postgres    false    2060    189    187            +           2606    16547    Prerequisite  fk2_p    FK CONSTRAINT     �   ALTER TABLE ONLY public."Prerequisite "
    ADD CONSTRAINT fk2_p FOREIGN KEY (prerequisite_course_id_2) REFERENCES public."Course"("Course_id") ON UPDATE CASCADE ON DELETE CASCADE;
 ?   ALTER TABLE ONLY public."Prerequisite " DROP CONSTRAINT fk2_p;
       public       postgres    false    190    2068    189            -           2606    16586    Participates fk5    FK CONSTRAINT     �   ALTER TABLE ONLY public."Participates"
    ADD CONSTRAINT fk5 FOREIGN KEY ("EID") REFERENCES public."Student"("EID") ON UPDATE CASCADE ON DELETE CASCADE;
 <   ALTER TABLE ONLY public."Participates" DROP CONSTRAINT fk5;
       public       postgres    false    191    2072    193            .           2606    16591    Participates fk6    FK CONSTRAINT     �   ALTER TABLE ONLY public."Participates"
    ADD CONSTRAINT fk6 FOREIGN KEY ("Course_id") REFERENCES public."Course"("Course_id") ON UPDATE CASCADE ON DELETE CASCADE;
 <   ALTER TABLE ONLY public."Participates" DROP CONSTRAINT fk6;
       public       postgres    false    193    189    2068            /           2606    16601    Mock_test fk7    FK CONSTRAINT     �   ALTER TABLE ONLY public."Mock_test"
    ADD CONSTRAINT fk7 FOREIGN KEY ("Course_id") REFERENCES public."Course"("Course_id") ON UPDATE CASCADE ON DELETE CASCADE;
 9   ALTER TABLE ONLY public."Mock_test" DROP CONSTRAINT fk7;
       public       postgres    false    189    2068    194            0           2606    16611    Enrolls fk_13    FK CONSTRAINT     �   ALTER TABLE ONLY public."Enrolls"
    ADD CONSTRAINT fk_13 FOREIGN KEY ("Course_id") REFERENCES public."Course"("Course_id") ON UPDATE CASCADE ON DELETE CASCADE;
 9   ALTER TABLE ONLY public."Enrolls" DROP CONSTRAINT fk_13;
       public       postgres    false    195    189    2068            1           2606    16616    Enrolls fk_14    FK CONSTRAINT     �   ALTER TABLE ONLY public."Enrolls"
    ADD CONSTRAINT fk_14 FOREIGN KEY ("EID") REFERENCES public."Student"("EID") ON UPDATE CASCADE ON DELETE CASCADE;
 9   ALTER TABLE ONLY public."Enrolls" DROP CONSTRAINT fk_14;
       public       postgres    false    191    2072    195            2           2606    16635    Takes fk_16    FK CONSTRAINT     �   ALTER TABLE ONLY public."Takes"
    ADD CONSTRAINT fk_16 FOREIGN KEY ("Test_ID") REFERENCES public."Mock_test"("Test_ID") ON UPDATE CASCADE ON DELETE CASCADE;
 7   ALTER TABLE ONLY public."Takes" DROP CONSTRAINT fk_16;
       public       postgres    false    196    194    2080            3           2606    16640    Takes fk_17    FK CONSTRAINT     �   ALTER TABLE ONLY public."Takes"
    ADD CONSTRAINT fk_17 FOREIGN KEY ("EID") REFERENCES public."Student"("EID") ON UPDATE CASCADE ON DELETE CASCADE;
 7   ALTER TABLE ONLY public."Takes" DROP CONSTRAINT fk_17;
       public       postgres    false    196    2072    191            %           2606    16460    Institute_Phone_no phone_id    FK CONSTRAINT     �   ALTER TABLE ONLY public."Institute_Phone_no"
    ADD CONSTRAINT phone_id FOREIGN KEY ("IID") REFERENCES public."Institute"("IID") ON UPDATE CASCADE ON DELETE CASCADE;
 G   ALTER TABLE ONLY public."Institute_Phone_no" DROP CONSTRAINT phone_id;
       public       postgres    false    186    185    2052            �      x�3�425�B����2NC�=... A��      �   (   x�s�7�t	�45�40�v�pv��4��7����� q1~      �      x�3�t�7�2�1z\\\ ��      �       x�s�7�4�4�420��54�54����� 5��      �   B   x�3����LLJvH�M���K���2�.I�K�/J�LKOA�0�tN�	IM��LN�)�Hr1z\\\ ��      �   =   x�˹�@��-������_�	���k�l�D	�;�g�bYӑn<,������2F      �      x�q1�440�t�7����� *�      �      x�3�t�7����� G�      �      x������ � �      �   /   x�3�t�H�,I̫L�LLJ64vHOK�K���.)MI�+����� �F�      �      x�q1�4�44������ �      �   :   x��7�07�4�0144�LLJ�4�
�7�461046422��p�q��4����� �
     