#! /bin/bash
#
# testCortexCommunityOrderedAssignment.sh
#% Init: 2022-04-22 13:57
#% Version: 2022-04-22 13:57
#% Copyright (C) 2022~2030 Xiaowei.Song <dawnwei.song@gmail.com>
#% http://restfmri.net/forum/XiaoweiSong
# Distributed under terms of the Academy Free License (AFL) license.
#

_CALLDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
_CALLPROG=$(readlink -f ${BASH_SOURCE[0]})
_CALLCMD="$0 $@"
#shopt -s expand_aliases ; source $(dawnbin)/slib.stack.sh
source $(dawnbin)/slib.bash.sh
 echo "$(date) | $0 '"$@"'" >> $(basename $0).LOG
usage(){ cat 1>&2 <<eou
Usage: $(grep -m1 '#% Version:' `readlink -f ${BASH_SOURCE[0]}`)
    ${0} [options]
    options:
$(sed --silent '/case/,$p;/case/d;/esac/q' $_CALLPROG |sed -e '/sed/,/case/d; /esac/d')
eou
exit;}
if [ $# -eq 0 ]; then usage;  fi
while [ $# -gt 0 ]; do
    case "$1" in
        '-v') export VERBOSE=1 ; shift ;;
        -V|--version) usage ;;
        '--template') T1TPL=$2 ; shift 2 ;;
        --no-*) key=${1#--no-}; eval "DO${key^^}=0"; shift ;;
        --version) usage;;
        '-*') elog 'Unknown parameters'; usage; ;;
        *) break ;;
    esac
done
verbose=${VERBOSE:-0} ;  test 0 -ne $verbose && set -x

#https://github.com/ColeLab/ColeAnticevicNetPartition
#cortex_community_order.mat - The order the Glasser parcels should be in to reveal the community structure identified by this network partition, in MATLAB format. Note that this file assumes you have the left hemisphere Glasser parcellation regions first, followed by the right hemisphere regions.
#cortex_community_order.txt - Same as the previous file, but in text format.
awk -v reorder=./cortex_community_order.txt '
BEGIN{
    freorder=reorder;
    n=0;
    while((getline < freorder)>0){
        nodeOrder[n++]=$1
    }
    close(freorder)
}
{nodeAssignment[$NR]=$1}
END{
    for(n=0;n<360;i++){

    }
}
' cortex_parcel_network_assignments.txt
#cortex_parcel_network_assignments.mat - A vector of numbers, one per cortical parcel, indicating which network that parcel was assigned to in the network partition (in MATLAB format). (Parcel order: L first, R second.)
#cortex_parcel_network_assignments.txt - Same as the previous file, but in text format.
