# https://harmony.pulsewidth.org.uk renders its MusicBrainz seed as a form of
# hidden inputs. This prints that seed and Harmony's warnings for review, then
# opens a local page that submits the form, landing in the release editor in
# the default browser. With --release=MBID, the form instead adds the
# release links that MBID lacks, via its edit page.
#
# libxml2 ignores a charset declared after <title>, so one is inserted ahead
# of it; otherwise UTF-8 text is decoded as Latin-1.
function musicbrainz_seed --description 'Seeds the MusicBrainz release editor from a release URL via Harmony'
    argparse n/dry-run r/release= -- $argv; or return
    set --local form_name release-seeder
    set --local data --data category=all
    if set --query _flag_release
        set form_name release-update-seeder
        set --append data --data musicbrainz=$_flag_release
    end
    for url in $argv
        set --local dir (mktemp -d -t musicbrainz_seed)
        curl --fail --silent --show-error --get \
            --data-urlencode "url=$url" $data \
            https://harmony.pulsewidth.org.uk/release |
            sed 's|<head><title>|<head><meta charset="utf-8"><title>|' >$dir/harmony.html
        or return

        set --local form (xmllint --html --xpath '//form[@name="'$form_name'"]' $dir/harmony.html 2>/dev/null)
        if test -z "$form"
            echo "musicbrainz_seed: Harmony returned no seed for $url" >&2
            xmllint --html --xpath '//div[contains(@class,"message")]//text()' $dir/harmony.html 2>/dev/null >&2
            return 1
        end

        xmllint --html --xpath '//div[contains(@class,"message")][not(contains(@class,"debug"))]//text()' $dir/harmony.html 2>/dev/null |
            string trim | string match --regex --entire '\S'
        echo
        string join '' $form | string replace --all '<input' \n'<input' |
            string replace --filter --regex '.*name="([^"]*)" value="([^"]*)".*' '$1: $2' |
            string replace --all '&#10;' ' ⏎ ' | string replace --all '&amp;' '&' | string replace --all '&quot;' '"'

        set --query _flag_dry_run; and continue
        begin
            echo '<!doctype html><meta charset="utf-8"><body onload="document.forms[0].submit()">'
            string join \n $form | string replace ' target="_blank"' ''
        end >$dir/seed.html
        open $dir/seed.html
    end
end
