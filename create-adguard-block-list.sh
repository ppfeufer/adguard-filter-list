#!/bin/bash

# Creates a combined DNS blocklist from multiple sources, so you don't have to add them all one after another.
# Including the defined default lists that AdGuard comes with

temp_blocklist_name="blocklist.tmp"
source_lists=(
    "https://adguardteam.github.io/AdGuardSDNSFilter/Filters/filter.txt" # AdGuard DNS filter
    "https://adaway.org/hosts.txt" # AdAway Default Blocklist
    "https://someonewhocares.org/hosts/zero/hosts" # Dan Pollock's List
    "https://raw.githubusercontent.com/crazy-max/WindowsSpyBlocker/master/data/hosts/spy.txt" # WindowsSpyBlocker - Hosts spy rules
    "https://raw.githubusercontent.com/durablenapkin/scamblocklist/master/adguard.txt" # Scam Blocklist by DurableNapkin
    "https://raw.githubusercontent.com/mitchellkrogza/The-Big-List-of-Hacked-Malware-Web-Sites/master/hosts" # The Big List of Hacked Malware Web Sites
    "https://curben.gitlab.io/malware-filter/urlhaus-filter-agh-online.txt" # Online Malicious URL Blocklist
    "https://raw.githubusercontent.com/ABPindo/indonesianadblockrules/master/subscriptions/abpindo.txt" # IDN: ABPindo
    "https://filtri-dns.ga/filtri.txt" # ITA: Filtri-DNS
    "https://raw.githubusercontent.com/yous/YousList/master/hosts.txt" # KOR: YousList
    "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/NorwegianExperimentalList%20alternate%20versions/NordicFiltersAdGuardHome.txt" # NOR: Dandelion Sprouts nordiske filtre
    "https://raw.githubusercontent.com/MajkiIT/polish-ads-filter/master/polish-pihole-filters/hostfile.txt" # POL: Polish filters for Pi hole
    "https://raw.githubusercontent.com/lassekongo83/Frellwits-filter-lists/master/Frellwits-Swedish-Hosts-File.txt" # SWE: Frellwit's Swedish Hosts File
    "https://anti-ad.net/easylist.txt" # CHN: anti-AD
    "https://raw.githubusercontent.com/DRSDavidSoft/additional-hosts/master/domains/blacklist/unwanted-iranian.txt" # IRN: Unwanted Iranian domains
    "https://raw.githubusercontent.com/cchevy/macedonian-pi-hole-blocklist/master/hosts.txt" # MKD: Macedonian Pi-hole Blocklist
    "https://paulgb.github.io/BarbBlock/blacklists/hosts-file.txt" # BarbBlock
    "https://winhelp2002.mvps.org/hosts.txt" # Winhelp MVPS Hosts
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters.txt" # uBlock filters - Default
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/badware.txt" # uBlock filters – Badware risks
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/privacy.txt" # uBlock filters – Privacy
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/resource-abuse.txt" # uBlock filters – Resource abuse
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/unbreak.txt" # uBlock filters – Unbreak
    "https://abp.oisd.nl" # OISD Full List
    "https://www.github.developerdan.com/hosts/lists/ads-and-tracking-extended.txt" # Lightswitch05 - Ads and Tracking
    "https://www.github.developerdan.com/hosts/lists/facebook-extended.txt" # Lightswitch05 - Facebook
    "https://www.github.developerdan.com/hosts/lists/amp-hosts-extended.txt" # Lightswitch05 - AMP Hosts
    "https://www.github.developerdan.com/hosts/lists/dating-services-extended.txt" # Lightswitch05 - Dating Services
    "https://www.github.developerdan.com/hosts/lists/tracking-aggressive-extended.txt" # Lightswitch05 - Tracking Aggressive
    "https://raw.githubusercontent.com/PolishFiltersTeam/KADhosts/master/KADhosts.txt" # PolishFiltersTeam - KADhosts
    "https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.Spam/hosts" # FadeMind - Hosts Extra (Spam Hosts)
    "https://v.firebog.net/hosts/static/w3kbl.txt" # Firebog - Personal Blocklist by WaLLy3K
    "https://v.firebog.net/hosts/neohostsbasic.txt" # Firebog - Neohostsbasic
    "https://v.firebog.net/hosts/AdguardDNS.txt" # Firebog - AdGuardDNS
    "https://v.firebog.net/hosts/Admiral.txt" # name: Firebog - Admiral
    "https://v.firebog.net/hosts/Easylist.txt" # Firebog - Easylist
    "https://v.firebog.net/hosts/Prigent-Crypto.txt" # Firebog - Prigent-Crypto
    "https://v.firebog.net/hosts/Prigent-Malware.txt" # Firebog - Prigent Malware
    "https://v.firebog.net/hosts/Shalla-mal.txt" # Firebog - Shalla-mal
    "https://raw.githubusercontent.com/matomo-org/referrer-spam-blacklist/master/spammers.txt" # Matomo - Referrer Spam Blacklist
    "https://raw.githubusercontent.com/VeleSila/yhosts/master/hosts" # VeleSila - yhosts
    "https://raw.githubusercontent.com/RooneyMcNibNug/pihole-stuff/master/SNAFU.txt" # RooneyMcNibNug - PiHole Stuff (SNAFU)
    "https://raw.githubusercontent.com/anudeepND/blacklist/master/adservers.txt" # anudeepND - Adservers
    "https://raw.githubusercontent.com/anudeepND/blacklist/master/facebook.txt" # anudeepND - Facebook
    "https://s3.amazonaws.com/lists.disconnect.me/simple_ad.txt" # Ad filter list by Disconnect
    "https://pgl.yoyo.org/adservers/serverlist.php?hostformat=adblockplus&showintro=1&mimetype=plaintext" # Peter Lowe's List
    "https://raw.githubusercontent.com/Perflyst/PiHoleBlocklist/master/SmartTV-AGH.txt" # Perflyst and Dandelion Sprout's Smart-TV Blocklist
    "https://raw.githubusercontent.com/Spam404/lists/master/main-blacklist.txt" # Spam404
    "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/GameConsoleAdblockList.txt" # Game Console Adblock List
    "https://raw.githubusercontent.com/hoshsadiq/adblock-nocoin-list/master/hosts.txt" # NoCoin Filter List
    "https://abpvn.com/android/abpvn.txt" # ABPVN List
    "https://raw.githubusercontent.com/FadeMind/hosts.extras/master/UncheckyAds/hosts" # FadeMind - UncheckyAds
    "https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.Risk/hosts" # FadeMind - Additional Risks
    "https://raw.githubusercontent.com/bigdargon/hostsVN/master/hosts" # bigdargon - hostsVN
    "https://raw.githubusercontent.com/jdlingyu/ad-wars/master/hosts" # jdlingyu - ad-wars
    "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/Alternate%20versions%20Anti-Malware%20List/AntiMalwareHosts.txt" # Dandelion Sprout's Anti-Malware List («hosts» file version)
    "https://osint.digitalside.it/Threat-Intel/lists/latestdomains.txt" # Threat-Intel
    "https://bitbucket.org/ethanr/dns-blacklists/raw/8575c9f96e5b4a1308f2f12394abd86d0927a4a0/bad_lists/Mandiant_APT1_Report_Appendix_D.txt" # ethanr - DNS-Blacklists
    "https://phishing.army/download/phishing_army_blocklist_extended.txt" # Phishing Army | The Blocklist to filter Phishing
    "https://gitlab.com/quidsup/notrack-blocklists/raw/master/notrack-malware.txt" # NoTrack Malware Blocklist
    "https://urlhaus.abuse.ch/downloads/hostfile/" # abuse.ch URLhaus Host file
    "https://zerodot1.gitlab.io/CoinBlockerLists/hosts_browser" # ZeroDot1 - CoinBlockerLists
    "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts" # StevenBlack - Hosts
)

date_now=`date +"%Y-%m-%d"`

# File header
cat > ${temp_blocklist_name} <<- EOM
######################################################################################
##                                                                                  ##
## This list is cumulated form more than 60 other DNS block lists                   ##
## used by AdGuardHome and Pi-Hole                                                  ##
##                                                                                  ##
## Last Update: ${date_now}                                                          ##
##                                                                                  ##
######################################################################################


EOM

# Add blocklists to temporary blocklist file
for blocklist_url in ${source_lists[@]}; do
    echo -e "## ${blocklist_url} ##\n"  >> ${temp_blocklist_name}

    wget --timeout=20 -O - ${blocklist_url} >> ${temp_blocklist_name}

    echo -e "\n\n\n" >> ${temp_blocklist_name}
    echo ${blocklist_url}
done

# Move the content into a file that's not ignored by git
cat ${temp_blocklist_name} > blocklist

git add blocklist
git commit -m 'Blocklist updated'
git push
