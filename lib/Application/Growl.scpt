FasdUAS 1.101.10   ��   ��    k             l      ��  ��    � �
-- lib -> _Growl
-- Wrapper to GrowlHelperApp
--
-- Growl version 1.2.x and earlier (outdated for 1.3!)
--
-- @author Scott Buchanan <buchanan.sc@gmail.com>
-- @link http://wafflesnatcha.github.com
     � 	 	� 
 - -   l i b   - >   _ G r o w l 
 - -   W r a p p e r   t o   G r o w l H e l p e r A p p 
 - - 
 - -   G r o w l   v e r s i o n   1 . 2 . x   a n d   e a r l i e r   ( o u t d a t e d   f o r   1 . 3 ! ) 
 - - 
 - -   @ a u t h o r   S c o t t   B u c h a n a n   < b u c h a n a n . s c @ g m a i l . c o m > 
 - -   @ l i n k   h t t p : / / w a f f l e s n a t c h a . g i t h u b . c o m 
   
  
 l     ��������  ��  ��        j     �� �� 0 _registered    m     ��
�� 
msng      l     ��������  ��  ��        j    �� �� 0 script_name    m    ��
�� 
msng      l     ��������  ��  ��        l     ��  ��    ; 5 Registers the current script for Growl Notifications     �   j   R e g i s t e r s   t h e   c u r r e n t   s c r i p t   f o r   G r o w l   N o t i f i c a t i o n s      l     ��������  ��  ��        l     ��   ��      @return void      � ! !    @ r e t u r n   v o i d   " # " l     ��������  ��  ��   #  $ % $ i    	 & ' & I      �� (���� 0 register   (  )�� ) o      ���� 0 notifications  ��  ��   ' k     I * *  + , + Z     - .���� - >     / 0 / n     1 2 1 o    ���� 0 _registered   2  f      0 m    ��
�� 
msng . L    
����  ��  ��   ,  3 4 3 l   ��������  ��  ��   4  5 6 5 Z    ( 7 8���� 7 =    9 : 9 o    ���� 0 script_name   : m    ��
�� 
msng 8 k    $ ; ;  < = < r    " > ? > l    @���� @ n     A B A 1    ��
�� 
pnam B  f    ��  ��   ? o      ���� 0 script_name   =  C�� C l  # #�� D E��   D { uset script_name to do shell script "f=`basename " & (quoted form of POSIX path of (path to me)) & "` && echo ${f%.*}"    E � F F � s e t   s c r i p t _ n a m e   t o   d o   s h e l l   s c r i p t   " f = ` b a s e n a m e   "   &   ( q u o t e d   f o r m   o f   P O S I X   p a t h   o f   ( p a t h   t o   m e ) )   &   " `   & &   e c h o   $ { f % . * } "��  ��  ��   6  G H G l  ) )��������  ��  ��   H  I J I O   ) C K L K I  - B���� M
�� .registernull��� ��� null��   M �� N O
�� 
appl N o   / 4���� 0 script_name   O �� P Q
�� 
anot P o   5 6���� 0 notifications   Q �� R S
�� 
dnot R o   7 8���� 0 notifications   S �� T��
�� 
iapp T l  9 > U���� U I  9 >�� V��
�� .earsffdralis        afdr V  f   9 :��  ��  ��  ��   L m   ) * W W6                                                                                  GRRR  alis    �  Macintosh HD               �:k�H+   ��GrowlHelperApp.app                                              ����        ����  	                	Resources     �:�      �$     �� �� ���!� e  ^Macintosh HD:Library: PreferencePanes: Growl.prefPane: Contents: Resources: GrowlHelperApp.app  &  G r o w l H e l p e r A p p . a p p    M a c i n t o s h   H D  LLibrary/PreferencePanes/Growl.prefPane/Contents/Resources/GrowlHelperApp.app  / ��   J  X�� X r   D I Y Z Y m   D E����  Z n      [ \ [ o   F H���� 0 _registered   \  f   E F��   %  ] ^ ] l     ��������  ��  ��   ^  _ ` _ i   
  a b a I      �� c���� 
0 notify   c  d�� d o      ���� 0 _config  ��  ��   b L      e e n     f g f o    ���� 0 _registered   g  f      `  h�� h l     ��������  ��  ��  ��       �� i���� j k��   i ���������� 0 _registered  �� 0 script_name  �� 0 register  �� 
0 notify  
�� 
msng
�� 
msng j �� '���� l m���� 0 register  �� �� n��  n  ���� 0 notifications  ��   l ���� 0 notifications   m ������ W���������������� 0 _registered  
�� 
msng
�� 
pnam
�� 
appl
�� 
anot
�� 
dnot
�� 
iapp
�� .earsffdralis        afdr�� 
�� .registernull��� ��� null�� J)�,� hY hOb  �  )�,Ec  OPY hO� *�b  ���)j � 
UOk)�,F k �� b���� o p���� 
0 notify  �� �� q��  q  ���� 0 _config  ��   o ���� 0 _config   p ���� 0 _registered  �� )�,Eascr  ��ޭ