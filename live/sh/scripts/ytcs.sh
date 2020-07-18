#!/usr/bin/env  sh

# Scrape comments from YouTube videos.
#
# Uses youtube-comment-scraper:
#   https://github.com/philbot9/youtube-comment-scraper/
#   https://blog.spiralofhope.com/?p=45279
#
# Requires my `search-JSON.sh`.



if   [ "$#" -ne 0 ]; then
  source_video_id="$( \echo  "$1"  |  \sed  's/.*v=//' )"
elif  \stat  --printf=''  'v.info.json'  2>/dev/null; then
  \echo  " * Found a JSON file"
  source_video_id="$( search-JSON.sh  'id'  'v.info.json' )"
elif  \stat  --printf=''  comments\ -\ *.csv  2>/dev/null; then
  \echo  " * Found a CSV file"
  # Example filename:
  #   'comments - 12345678901 - 2020-05-24 12։34.csv'
  # Example id:
  #   12345678901
  for filename in comments\ -\ *.csv; do
    source_video_id=$( \echo  "$filename" | \cut  --delimiter=' '  --fields=3 )
    # Only process the first file found:
    break
  done
fi


if [ -z "$source_video_id" ]; then
  \echo  " * No source determined/specified."
  return  1
fi

comment_filename="comments - $source_video_id - $( \date  --utc  +%Y-%m-%d\ %H։%M )"
\echo  " * Downloading comments from.."
\echo  "   id:    \"$source_video_id\""
\echo  "   into:  \"$comment_filename\""


:<<'}'   #  youtube-comment-scraper
# https://github.com/philbot9/youtube-comment-scraper-cli/
{
  \youtube-comment-scraper  \
    --format csv  \
    --stream  \
    --  \
    "$source_video_id"  >  \
    "$comment_filename".csv
# |  \tee "$comment_filename".csv
}
:<<'}'   #  youtube-comment-scraper's other method
{
\youtube-comment-scraper  \
  --format csv  \
  --outputFile "$comment_filename".csv   \
  --  \
  "$source_video_id"
}



#:<<'}'   #  youtube-comment-downloader
# https://github.com/egbertbouman/youtube-comment-downloader
{
  \youtube-comment-downloader  \
    --youtubeid="$source_video_id"  \
    --output="$comment_filename".ytcs2.json
}



# I'm left with a zero-size file if the download fails; delete it.
[ -s "$comment_filename" ]  ||  \rm  --force  "$comment_filename"



