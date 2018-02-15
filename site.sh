# User Code.

# Configuration.
site_owner_name="Sunaina Pai"
NL="
"

# Setup staging directory.
rm -rf _site
mkdir _site
cp -r css _site
ln -s ~/blob/sunainapai.in/img _site/img

# User functions.

get_posts_newest_first()
{
    posts=$(find _posts -name "*.html" | sort -r)
    # $NL to fix last post to be displayed in the post list
    printf %s "$posts$NL"

    unset posts
}

print_recent_posts()
{
    get_posts_newest_first | head -n 5 | print_post_list recent
}

print_archive_posts()
{
    get_posts_newest_first | print_post_list archive
}

print_post_list()
{
    list_type=$1

    while read -r file
    do
        include "$file" > /tmp/o.html
        post_desc=$(strip_html < /tmp/o.html | truncate_text 25 |
                    grep "[[:graph:]]" | head -n 2) 
        post_url=/blog/$(get_post_id "$file")/
        post_year=$(get_post_year "$file")

        if [ "$list_type" = archive ]
        then
            if [ "$prev_post_year" != "$post_year" ]
            then
                printf "%s" "<h2>$post_year</h2><hr>"
                prev_post_year=$post_year
            fi
            printf "%s" "<article><h3><a href="$post_url">$post_title</a></h3>"
        else
            printf "%s" "<article><h2><a href="$post_url">$post_title</a></h2>"
        fi

        printf "%s" "<p>$post_desc <a href="$post_url">...</a></p></article>"
    done

    unset list_type
    unset file
    unset post_desc
    unset post_url
    unset post_year
    unset prev_post_year
}

print_related_posts()
{
    get_posts_newest_first | head -n 3 |
    while read -r file
    do
        include "$file" > /tmp/o.html
        post_url=/blog/$(get_post_id "$file")/
        printf "%s" "<li><a href="$post_url">$post_title</a></li>"
    done

    unset file
    unset post_url
}

# Render home, about, blog.
render_dir _web "*.html" _layouts/default.html / 
mv _site/home/index.html _site/index.html
rm -rf _site/home

# Render posts.
render_dir _posts "*.html" _layouts/post.html /blog
