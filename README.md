# AdGuardHome DNS Filter List

## What is this?

This is a DNS block list that can be used for AdGuardHome and Pi-Hole. (AdGuardHome is tested but should also work in Pi-Hole without problems)

This list combines more than 60 other lists, including the default lists from AdGuardHome, into one single list, so you don't have to add countless lists to your AdGuardHome or Pi-Hole, but just this one.


## How can I use it?

Pretty simple, copy this link (https://raw.githubusercontent.com/ppfeufer/adguard-filter-list/master/blocklist) and add it to your AgDuardHome or Pi-Hole DNS blocklists.


## Which lists are combined here?

Which lists I'm using here, you can see in the shell script that puts this list together » [click here](create-adguard-block-list.sh)


## Do you curate the lists?

Absolutely not.

All these lists are considered 3rd party from my point of view. I have no influence over them at all. All I do is combine the lists I was using into one single list, so my list of block lists isn't massive. (That was a lot of lists in one sentence ...)


## How often is this list updated?

Daily


## Whitelist exceptions you mighht want to make

### Google Fonts

As stated [here](https://github.com/lightswitch05/hosts#google-fonts) from one of the lists I am using, you might have to whitelist `fonts.gstatic.com`. To do so, add the following to your whitelist:

```plainext
@@||fonts.gstatic.com^$important
```


## Last words

You are free to use this list, but I can give you no guarantee for it, since none of the lists combined here is managed by me.

If you want to create your own combined list, feel free to fork this repository and change the shell script I included to start your own voyage.
