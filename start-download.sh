#!/bin/bash

wget https://gist.githubusercontent.com/mattzab/14f29795a44e04611f343907001ae1fc/raw/68e2688ca086346d4d463d37d1bab4289dcd417b/continue-librivox-download.sh
mkdir 'librivox.org'
cd 'librivox.org'
echo Download updated Book Listing
wget -O list1.xml "https://librivox.org/api/feed/audiobooks/?offset=0&limit=10000&fields=%7Blanguage,authors,title,url_zip_file%7B"
wget -O list2.xml "https://librivox.org/api/feed/audiobooks/?offset=10000&limit=10000&fields=%7Blanguage,authors,title,url_zip_file%7B"


echo
echo Cleaning up XML file to be used with Wget...
echo
echo replace trailing title tag with zip file extension
sed -i -- 's,</title>,.zip\n,g' *.xml
echo
echo replace leading book tag with single line break
sed -i -- 's,<book>,\n,g' *.xml
echo
echo replace trailing zip url tag with single line break
sed -i -- 's,</url_zip_file>,\n,g' *.xml
echo
echo replace trailing language tag with single line break
sed -i -- 's,</language>,.\n,g' *.xml
echo
echo replace leading first name tag with single line break
sed -i -- 's,<first_name>,\n,g' *.xml
echo
echo replace leading last name tag with single line break
sed -i -- 's,<last_name>,\n,g' *.xml
echo
echo replace trailing first name tag with period separator
sed -i -- 's,</first_name>,.,g' *.xml
echo
echo replace trailing last name tag with period separator
sed -i -- 's,</last_name>,.,g' *.xml
echo
echo remove exclamation points from titles
sed -i -- 's,!,,g' *.xml
echo
echo remove single quotes from titles
sed -i "s,',,g" *.xml
echo
echo remove ampersand from titles
sed -i 's,&amp;,And,g' *.xml
echo
echo replace colon with period in verses
sed -i -- 's,:,.,g' *.xml
echo
echo restore the colon in url addresses
sed -i -- 's,p./,p:/,g' *.xml
echo
echo remove spaces from titles
sed -i -- 's, ,,g' *.xml
echo
echo remove leading title tag
sed -i -- 's,<title>,,g' *.xml
echo
echo remove leading url tag
sed -i -- 's,<url_zip_file>,,g' *.xml
echo
echo remove leading language tag
sed -i -- 's,<language>,,g' *.xml
echo
echo remove all remaining xml tags and everything inbetween
sed -i 's,<.*>,,g' *.xml
echo
echo cleanup white space
sed -i '/^$/d' *.xml
echo
sh ../continue-librivox-download.sh