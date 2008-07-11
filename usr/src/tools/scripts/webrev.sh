#

span.chmod {
    font-size: 0.7em;
    color: #db7800;
}
# variable C in the $AWK script below.
	$AWK '
	NF == 0 || /<span class="/ {
	$AWK '
	$AWK '
	# Post-process the HTML files by running them back through $AWK
	html_quote < $1 | $AWK -f /tmp/$$.file1 > /tmp/$$.file1.html
	html_quote < $2 | $AWK -f /tmp/$$.file2 > /tmp/$$.file2.html
	print "<title>$WNAME Sdiff $TPATH/$TNAME</title>"
	$AWK '
	html_quote | $AWK '
	print "<title>$WNAME $WHICH $TNAME</title>"
	html_quote | $AWK '{line += 1 ; printf "%4d %s\n", line, $0 }'
# comments_from_teamware {text|html} parent-file child-file
	if [[ ! -f $PWS/${2%/*}/SCCS/s.${2##*/} && -n $RWS ]]; then
		pfile=$RWS/$2
	fi

		psid=$($SCCS prs -d:I: $pfile 2>/dev/null)
	set -A sids $($SCCS prs -l -r$psid -d:I: $cfile 2>/dev/null)
			$SCCS prs -l -r$sid1 $cfile  2>/dev/null | \
			    $AWK "$nawkprg"
		$SCCS prs -l -r$sid1 $cfile  2>/dev/null | \
		    html_quote | bug2url | sac2url | $AWK "$nawkprg"
# comments_from_wx {text|html} filepath
#
# Given the pathname of a file, find its location in a "wx" active
# file list and print the following comment.  Output is either text or
# HTML; if the latter, embedded bugids (sequence of 5 or more digits)
# are turned into URLs.
# This is also used with Mercurial and the file list provided by hg-active.
	comm=`$AWK '
	if [[ -z $comm ]]; then
		comm="*** NO COMMENTS ***"
	fi

		print -- "$comm"
	print -- "$comm" | html_quote | bug2url | sac2url

	#
	# Mercurial support uses a file list in wx format, so this
	# will be used there, too
	#
	eval $( diff -e $1 $2 | $AWK '
	# End of $AWK, Check to see if any trouble occurred.
	unc=`wc -l < $1`
	$AWK '{ c = 1; print;
	if [[ -n $codemgr_parent && -z $parent_webrev ]]; then
	    $AWK '
#
# Call hg-active to get the active list output in the wx active list format
#
function hg_active_wxfile
	typeset child=$1
	typeset parent=$2
	TMPFLIST=/tmp/$$.active
	$HG_ACTIVE -w $child -p $parent > $TMPFLIST
	wxfile=$TMPFLIST
}
#
# flist_from_mercurial
# Call hg-active to get a wx-style active list, and hand it off to
# flist_from_wx
#
function flist_from_mercurial 
{
	typeset child=$1
	typeset parent=$2
	print " File list from: hg-active -p $parent ...\c"

	if [[ ! -x $HG_ACTIVE ]]; then
		print		# Blank line for the \c above
		print -u2 "Error: hg-active tool not found.  Exiting"
		exit 1
	fi
	hg_active_wxfile $child $parent
	
	# flist_from_wx prints the Done, so we don't have to.
	flist_from_wx $TMPFLIST
# flist_from_subversion
# Generate the file list by extracting file names from svn status.
function flist_from_subversion
	CWS=$1
	OLDPWD=$2

	cd $CWS
	print -u2 " File list from: svn status ... \c"
	svn status | $AWK '/^[ACDMR]/ { print $NF }' > $FLIST
	print -u2 " Done."
	cd $OLDPWD
}

function env_from_flist
{
	[[ -r $FLIST ]] || return

	# Use "eval" to set env variables that are listed in the file
	# list.  Then copy those into our local versions of those
	# variables if they have not been set already.
	eval `sed -e "s/#.*$//" $FLIST | grep = `

	if [[ -z $codemgr_ws && -n $CODEMGR_WS ]]; then
		codemgr_ws=$CODEMGR_WS
		export CODEMGR_WS
	# Check to see if CODEMGR_PARENT is set in the flist file.
	if [[ -z $codemgr_parent && -n $CODEMGR_PARENT ]]; then
		codemgr_parent=$CODEMGR_PARENT
		export CODEMGR_PARENT
	ppath=$ppath:/opt/onbld/bin/`uname -p`
function get_file_mode
{
	$PERL -e '
		if (@stat = stat($ARGV[0])) {
			$mode = $stat[2] & 0777;
			printf "%03o\n", $mode;
			exit 0;
		} else {
			exit 1;
		}
	    ' $1
}

function build_old_new_teamware
{
	typeset olddir="$1"
	typeset newdir="$2"

	# If the child's version doesn't exist then
	# get a readonly copy.

	if [[ ! -f $CWS/$DIR/$F && -f $CWS/$DIR/SCCS/s.$F ]]; then
		$SCCS get -s -p $CWS/$DIR/$F > $CWS/$DIR/$F
	fi

	# The following two sections propagate file permissions the
	# same way SCCS does.  If the file is already under version
	# control, always use permissions from the SCCS/s.file.  If
	# the file is not under SCCS control, use permissions from the
	# working copy.  In all cases, the file copied to the webrev
	# is set to read only, and group/other permissions are set to
	# match those of the file owner.  This way, even if the file
	# is currently checked out, the webrev will display the final
	# permissions that would result after check in.

	#
	# Snag new version of file.
	#
	rm -f $newdir/$DIR/$F
	cp $CWS/$DIR/$F $newdir/$DIR/$F
	if [[ -f $CWS/$DIR/SCCS/s.$F ]]; then
		chmod `get_file_mode $CWS/$DIR/SCCS/s.$F` \
		    $newdir/$DIR/$F
	fi
	chmod u-w,go=u $newdir/$DIR/$F

	#
	# Get the parent's version of the file. First see whether the
	# child's version is checked out and get the parent's version
	# with keywords expanded or unexpanded as appropriate.
	#
	if [[ -f $PWS/$PDIR/$PF && ! -f $PWS/$PDIR/SCCS/s.$PF && \
	    ! -f $PWS/$PDIR/SCCS/p.$PF ]]; then
		# Parent is not a real workspace, but just a raw
		# directory tree - use the file that's there as
		# the old file.

		rm -f $olddir/$PDIR/$PF
		cp $PWS/$PDIR/$PF $olddir/$PDIR/$PF
	else
		if [[ -f $PWS/$PDIR/SCCS/s.$PF ]]; then
			real_parent=$PWS
		else
			real_parent=$RWS
		fi

		rm -f $olddir/$PDIR/$PF

		if [[ -f $real_parent/$PDIR/$PF ]]; then
			if [ -f $CWS/$DIR/SCCS/p.$F ]; then
				$SCCS get -s -p -k $real_parent/$PDIR/$PF > \
				    $olddir/$PDIR/$PF
			else
				$SCCS get -s -p    $real_parent/$PDIR/$PF > \
				    $olddir/$PDIR/$PF
			fi
			chmod `get_file_mode $real_parent/$PDIR/SCCS/s.$PF` \
			    $olddir/$PDIR/$PF
		fi
	fi
	if [[ -f $olddir/$PDIR/$PF ]]; then
		chmod u-w,go=u $olddir/$PDIR/$PF
	fi
}

function build_old_new_mercurial
{
	typeset olddir="$1"
	typeset newdir="$2"
	typeset old_mode=
	typeset new_mode=
	typeset file

	#
	# Get old file mode, from the parent revision manifest entry.
	# Mercurial only stores a "file is executable" flag, but the
	# manifest will display an octal mode "644" or "755".
	#
	if [[ "$PDIR" == "." ]]; then
		file="$PF"
	else
		file="$PDIR/$PF"
	fi
	file=`echo $file | sed 's#/#\\\/#g'`
	# match the exact filename, and return only the permission digits
	old_mode=`sed -n -e "/^\\(...\\) . ${file}$/s//\\1/p" \
	    < $HG_PARENT_MANIFEST`

	#
	# Get new file mode, directly from the filesystem.
	# Normalize the mode to match Mercurial's behavior.
	#
	new_mode=`get_file_mode $CWS/$DIR/$F`
	if [[ -n "$new_mode" ]]; then
		if [[ "$new_mode" = *[1357]* ]]; then
			new_mode=755
		else
			new_mode=644
		fi
	fi

	#
	# new version of the file.
	#
	rm -rf $newdir/$DIR/$F
	if [[ -e $CWS/$DIR/$F ]]; then
		cp $CWS/$DIR/$F $newdir/$DIR/$F
		if [[ -n $new_mode ]]; then
			chmod $new_mode $newdir/$DIR/$F
		else
			# should never happen
			print -u2 "ERROR: set mode of $newdir/$DIR/$F"
		fi
	fi

	#
	# parent's version of the file
	#
	# Note that we get this from the last version common to both
	# ourselves and the parent.  References are via $CWS since we have no
	# guarantee that the parent workspace is reachable via the filesystem.
	#
	if [[ -n $parent_webrev && -e $PWS/$PDIR/$PF ]]; then
		cp $PWS/$PDIR/$PF $olddir/$PDIR/$PF
	elif [[ -n $HG_PARENT ]]; then
		hg cat -R $CWS -r $HG_PARENT $CWS/$PDIR/$PF > \
		    $olddir/$PDIR/$PF 2>/dev/null

		if [ $? -ne 0 ]; then
			rm -f $olddir/$PDIR/$PF
		else
			if [[ -n $old_mode ]]; then
				chmod $old_mode $olddir/$PDIR/$PF
			else
				# should never happen
				print -u2 "ERROR: set mode of $olddir/$PDIR/$PF"
			fi
		fi
	fi
}

function build_old_new_subversion
{
	typeset olddir="$1"
	typeset newdir="$2"

	# Snag new version of file.
	rm -f $newdir/$DIR/$F
	[[ -e $CWS/$DIR/$F ]] && cp $CWS/$DIR/$F $newdir/$DIR/$F

	if [[ -n $PWS && -e $PWS/$PDIR/$PF ]]; then
		cp $PWS/$PDIR/$PF $olddir/$PDIR/$PF
	else
		# Get the parent's version of the file.
		svn status $CWS/$DIR/$F | read stat file
		if [[ $stat != "A" ]]; then
			svn cat -r BASE $CWS/$DIR/$F > $olddir/$PDIR/$PF
		fi
	fi
}

function build_old_new_unknown
{
	typeset olddir="$1"
	typeset newdir="$2"

	#
	# Snag new version of file.
	#
	rm -f $newdir/$DIR/$F
	[[ -e $CWS/$DIR/$F ]] && cp $CWS/$DIR/$F $newdir/$DIR/$F

	#
	# Snag the parent's version of the file.
	# 
	if [[ -f $PWS/$PDIR/$PF ]]; then
		rm -f $olddir/$PDIR/$PF
		cp $PWS/$PDIR/$PF $olddir/$PDIR/$PF
	fi
}

function build_old_new
{
	typeset WDIR=$1
	typeset PWS=$2
	typeset PDIR=$3
	typeset PF=$4
	typeset CWS=$5
	typeset DIR=$6
	typeset F=$7

	typeset olddir="$WDIR/raw_files/old"
	typeset newdir="$WDIR/raw_files/new"

	mkdir -p $olddir/$PDIR
	mkdir -p $newdir/$DIR

	if [[ $SCM_MODE == "teamware" ]]; then
		build_old_new_teamware "$olddir" "$newdir"
	elif [[ $SCM_MODE == "mercurial" ]]; then
		build_old_new_mercurial "$olddir" "$newdir"
	elif [[ $SCM_MODE == "subversion" ]]; then
		build_old_new_subversion "$olddir" "$newdir"
	elif [[ $SCM_MODE == "unknown" ]]; then
		build_old_new_unknown "$olddir" "$newdir"
	fi

	if [[ ! -f $olddir/$PDIR/$PF && ! -f $newdir/$DIR/$F ]]; then
		print "*** Error: file not in parent or child"
		return 1
	fi
	return 0
}


SCM Specific Options:
	TeamWare: webrev [common-options] -l [arguments to 'putback']

	CODEMGR_WS: Workspace location.
	CODEMGR_PARENT: Parent workspace location.
PATH=$(dirname $(whence $0)):$PATH

[[ -z $HG_ACTIVE ]] && HG_ACTIVE=`look_for_prog hg-active`
[[ -z $WHICH_SCM ]] && WHICH_SCM=`look_for_prog which_scm`
[[ -z $SCCS ]] && SCCS=`look_for_prog sccs`
[[ -z $AWK ]] && AWK=`look_for_prog nawk`
[[ -z $AWK ]] && AWK=`look_for_prog gawk`
[[ -z $AWK ]] && AWK=`look_for_prog awk`

if [[ ! -x $WHICH_SCM ]]; then
	print -u2 "Error: Could not find which_scm.  Exiting."
	exit 1
fi

$WHICH_SCM | read SCM_MODE junk || exit 1
case "$SCM_MODE" in
teamware|mercurial|subversion)
	;;
unknown)
	if [[ $flist_mode == "auto" ]]; then
		print -u2 "Unable to determine SCM in use and file list not specified"
		print -u2 "See which_scm(1) for SCM detection information."
		exit 1
	fi
	;;
*)
	if [[ $flist_mode == "auto" ]]; then
		print -u2 "Unsupported SCM in use ($SCM_MODE) and file list not specified"
		exit 1
	fi
	;;
esac
	if [[ $SCM_MODE == "teamware" ]]; then
		flist_from_teamware "$*"
	else
		print -u2 -- "Error: -l option only applies to TeamWare"
		exit 1
	fi
	if [[ ! -r $wxfile ]]; then
		print -u2 "$wxfile: no such file or not readable"
		usage
	fi

	[[ -z $codemgr_ws ]] && codemgr_ws=`workspace name`
	#
	# Observe true directory name of CODEMGR_WS, as used later in
	# webrev title.
	#
	codemgr_ws=$(cd $codemgr_ws;print $PWD)


	[[ -n $parent_webrev ]] && RWS=$(workspace parent $CWS)

elif [[ $SCM_MODE == "mercurial" ]]; then
	[[ -z $codemgr_ws && -n $CODEMGR_WS ]] && \
	    codemgr_ws=`hg root -R $CODEMGR_WS 2>/dev/null`

	[[ -z $codemgr_ws ]] && codemgr_ws=`hg root 2>/dev/null`

	#
	# Parent can either be specified with -p
	# Specified with CODEMGR_PARENT in the environment
	# or taken from hg's default path.
	#

	if [[ -z $codemgr_parent && -n $CODEMGR_PARENT ]]; then
		codemgr_parent=$CODEMGR_PARENT
	fi

	if [[ -z $codemgr_parent ]]; then
		codemgr_parent=`hg path -R $codemgr_ws default 2>/dev/null`
	fi

	CWS_REV=`hg parent -R $codemgr_ws --template '{node|short}' 2>/dev/null`
	CWS=$codemgr_ws
	PWS=$codemgr_parent

	# 
	# If the parent is a webrev, we want to do some things against
	# the natural workspace parent (file list, comments, etc)
	#
	if [[ -n $parent_webrev ]]; then
		real_parent=$(hg path -R $codemgr_ws default 2>/dev/null)
	else
		real_parent=$PWS
	fi

	#
	# If hg-active exists, then we run it.  In the case of no explicit
	# flist given, we'll use it for our comments.  In the case of an
	# explicit flist given we'll try to use it for comments for any
	# files mentioned in the flist.
	#
	if [[ -z $flist_done ]]; then
		flist_from_mercurial $CWS $real_parent
		flist_done=1
	fi

	#
	# If we have a file list now, pull out any variables set
	# therein.  We do this now (rather than when we possibly use
	# hg-active to find comments) to avoid stomping specifications
	# in the user-specified flist.
	# 
	if [[ -n $flist_done ]]; then
		env_from_flist
	fi

	#
	# Only call hg-active if we don't have a wx formatted file already
	#
	if [[ -x $HG_ACTIVE && -z $wxfile ]]; then
		print "  Comments from: hg-active -p $real_parent ...\c"
		hg_active_wxfile $CWS $real_parent
		print " Done."
	fi
	
	#
	# At this point we must have a wx flist either from hg-active,
	# or in general.  Use it to try and find our parent revision,
	# if we don't have one.
	#
	if [[ -z $HG_PARENT ]]; then
		eval `sed -e "s/#.*$//" $wxfile | grep HG_PARENT=`
	fi

	#
	# If we still don't have a parent, we must have been given a
	# wx-style active list with no HG_PARENT specification, run
	# hg-active and pull an HG_PARENT out of it, ignore the rest.
	#
	if [[ -z $HG_PARENT && -x $HG_ACTIVE ]]; then
		$HG_ACTIVE -w $codemgr_ws -p $real_parent | \
		    eval `sed -e "s/#.*$//" | grep HG_PARENT=`
	elif [[ -z $HG_PARENT ]]; then
		print -u2 "Error: Cannot discover parent revision"
		exit 1
	fi
elif [[ $SCM_MODE == "subversion" ]]; then
	if [[ -n $CODEMGR_WS && -d $CODEMGR_WS/.svn ]]; then
		CWS=$CODEMGR_WS
	else
		svn info | while read line; do
			if [[ $line == "URL: "* ]]; then
				url=${line#URL: }
			elif [[ $line == "Repository Root: "* ]]; then
				repo=${line#Repository Root: }
			fi
		done

		rel=${url#$repo} 
		CWS=${PWD%$rel}
	fi

	#
	# We only will have a real parent workspace in the case one
	# was specified (be it an older webrev, or another checkout).
	#
	[[ -n $codemgr_parent ]] && PWS=$codemgr_parent

	if [[ -z $flist_done && $flist_mode == "auto" ]]; then
		flist_from_subversion $CWS $OLDPWD
	fi
else
    if [[ $SCM_MODE == "unknown" ]]; then
	print -u2 "    Unknown type of SCM in use"
    else
	print -u2 "    Unsupported SCM in use: $SCM_MODE"
    fi

    env_from_flist

    if [[ -z $CODEMGR_WS ]]; then
	print -u2 "SCM not detected/supported and CODEMGR_WS not specified"
	exit 1
    fi

    if [[ -z $CODEMGR_PARENT ]]; then
	print -u2 "SCM not detected/supported and CODEMGR_PARENT not specified"
	exit 1
    fi

    CWS=$CODEMGR_WS
    PWS=$CODEMGR_PARENT
if [[ -n $CWS_REV ]]; then
	print "      Workspace: $CWS (at $CWS_REV)"
else
	print "      Workspace: $CWS"
fi
	if [[ -n $HG_PARENT ]]; then
		hg_parent_short=`echo $HG_PARENT \
			| sed -e 's/\([0-9a-f]\{12\}\).*/\1/'`
		print "Compare against: $PWS (at $hg_parent_short)"
	else
		print "Compare against: $PWS"
	fi
#
# For Mercurial, create a cache of manifest entries.
#
if [[ $SCM_MODE == "mercurial" ]]; then
	#
	# Transform the FLIST into a temporary sed script that matches
	# relevant entries in the Mercurial manifest as follows:
	# 1) The script will be used against the parent revision manifest,
	#    so for FLIST lines that have two filenames (a renamed file)
	#    keep only the old name.
	# 2) Escape all forward slashes the filename.
	# 3) Change the filename into another sed command that matches
	#    that file in "hg manifest -v" output:  start of line, three
	#    octal digits for file permissions, space, a file type flag
	#    character, space, the filename, end of line.
	#
	SEDFILE=/tmp/$$.manifest.sed
	sed '
		s#^[^ ]* ##
		s#/#\\\/#g
		s#^.*$#/^... . &$/p#
	' < $FLIST > $SEDFILE

	#
	# Apply the generated script to the output of "hg manifest -v"
	# to get the relevant subset for this webrev.
	#
	HG_PARENT_MANIFEST=/tmp/$$.manifest
	hg -R $CWS manifest -v -r $HG_PARENT |
	    sed -n -f $SEDFILE > $HG_PARENT_MANIFEST
fi

	# We stash old and new files into parallel directories in $WDIR
	build_old_new "$WDIR" "$PWS" "$PDIR" "$PF" "$CWS" "$DIR" "$F" || \
	    continue
	#
	# Keep the old PWD around, so we can safely switch back after
	# diff generation, such that build_old_new runs in a
	# consistent environment.
	#
	OWD=$PWD
	if [[ -f $ofile ]]; then
		source_to_html Old $PP < $ofile > $WDIR/$DIR/$F-.html
	cd $OWD

# Get the preparer's name:
# If the SCM detected is Mercurial, and the configuration property
# ui.username is available, use that, but be careful to properly escape
# angle brackets (HTML syntax characters) in the email address.
#
# Otherwise, use the current userid in the form "John Doe (jdoe)", but
# to maintain compatibility with passwd(4), we must support '&' substitutions.
#
preparer=
if [[ "$SCM_MODE" == mercurial ]]; then
	preparer=`hg showconfig ui.username 2>/dev/null`
	if [[ -n "$preparer" ]]; then
		preparer="$(echo "$preparer" | html_quote)"
	fi
fi
if [[ -z "$preparer" ]]; then
	preparer=$(
	    $PERL -e '
	        ($login, $pw, $uid, $gid, $quota, $cmt, $gcos) = getpwuid($<);
	        if ($login) {
	            $gcos =~ s/\&/ucfirst($login)/e;
	            printf "%s (%s)\n", $gcos, $login;
	        } else {
	            printf "(unknown)\n";
	        }
	')
print "<tr><th>Prepared by:</th><td>$preparer on `date`</td></tr>"
print "<tr><th>Workspace:</th><td>$CWS"
if [[ -n $CWS_REV ]]; then
	print "(at $CWS_REV)"
fi
print "</td></tr>"
	if [[ -n $hg_parent_short ]]; then
		print "(at $hg_parent_short)"
	fi
		oldname="$PP"
	mv_but_nodiff=
	cmp $WDIR/raw_files/old/$PP $WDIR/raw_files/new/$P > /dev/null 2>&1
	if [[ $? == 0 && -n "$oldname" ]]; then
		mv_but_nodiff=1
	fi

	print "<b>$P</b>"

	# For renamed files, clearly state whether or not they are modified
	if [[ -n "$oldname" ]]; then
		if [[ -n "$mv_but_nodiff" ]]; then
			print "<i>(renamed only, was $oldname)</i>"
		else
			print "<i>(modified and renamed, was $oldname)</i>"
		fi
	fi

	# If there's an old file, but no new file, the file was deleted
	if [[ -f $F-.html && ! -f $F.html ]]; then
		print " <i>(deleted)</i>"
	fi

	if [[ $SCM_MODE == "teamware" ||
	    $SCM_MODE == "mercurial" ||
	    $SCM_MODE == "unknown" ]]; then

		# Include warnings for important file mode situations:
		# 1) New executable files
		# 2) Permission changes of any kind
		# 3) Existing executable files

		old_mode=
		if [[ -f $WDIR/raw_files/old/$PP ]]; then
			old_mode=`get_file_mode $WDIR/raw_files/old/$PP`
		fi

		new_mode=
		if [[ -f $WDIR/raw_files/new/$P ]]; then
			new_mode=`get_file_mode $WDIR/raw_files/new/$P`
		fi

		if [[ -z "$old_mode" && "$new_mode" = *[1357]* ]]; then
			print "<span class=\"chmod\">"
			print "<p>new executable file: mode $new_mode</p>"
			print "</span>"
		elif [[ -n "$old_mode" && -n "$new_mode" &&
		    "$old_mode" != "$new_mode" ]]; then
			print "<span class=\"chmod\">"
			print "<p>mode change: $old_mode to $new_mode</p>"
			print "</span>"
		elif [[ "$new_mode" = *[1357]* ]]; then
			print "<span class=\"chmod\">"
			print "<p>executable file: mode $new_mode</p>"
			print "</span>"
		fi
	fi
