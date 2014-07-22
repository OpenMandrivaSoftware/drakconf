#!/usr/bin/perl

# Copyright (C) 2008 Mandriva
#                         Thierry Vignaud <tvignaud@mandriva.com>
#
# This program is free software; you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation; either version 2, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.

use MDK::Common;
use lib qw(./lib);

package common;

sub N_ { $_[0] }

package main;

use MDV::Control_Center;

output('mcc.conf', map { s/ /_/g; "ENABLE_$_=yes\n" } sort keys %programs);
