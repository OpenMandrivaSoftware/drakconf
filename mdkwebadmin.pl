#!/usr/bin/perl -w
################################################################################
#                                                                              # 
#                                                                              #
# Copyright (C) 2002 MandrakeSoft                                              #
#
# Daouda Lo <daouda@mandrakesoft.com>                                          #
#                                                                              #
# This program is free software; you can redistribute it and/or modify         #
# it under the terms of the GNU General Public License Version 2 as            #
# published by the Free Software Foundation.                                   #
#                                                                              #
# This program is distributed in the hope that it will be useful,              #
# but WITHOUT ANY WARRANTY; without even the implied warranty of               #
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the                #
# GNU General Public License for more details.                                 #
#                                                                              #
# You should have received a copy of the GNU General Public License            #
# along with this program; if not, write to the Free Software                  #
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.   #
################################################################################


use lib qw(/usr/lib/libDrakX);
use standalone;
use ugtk2 qw(:all);
use common;

my ($ent, $link);
my $execbin = '/usr/bin/mdkwebadmin';
my ($opt) = @ARGV;
@ARGV == 1 && ($opt eq '--direct' || $opt eq '--link') or exit(1);

$opt eq '--direct' and exec "$execbin";
my $w = ugtk2->new('mdkwebadmin.pl');
unless ($::isEmbedded) {
    $w->{rwindow}->set_title(N("Connect to remote Site"));
    $w->{window}->set_border_width(5);
}  

gtkadd($w->{window},
       gtkpack_(Gtk2::VBox->new(0,5),
		1, Gtk2::Label->new(N("Enter the webmin address server below \n")),
		1, $ent = Gtk2::Entry->new(),
		0, Gtk2::HSeparator->new,
		0, gtkpack(create_hbox(),
			   gtksignal_connect(Gtk2::Button->new(N("Connect")), clicked => sub {
						 $link = 'https://' . $ent->get_text() . ':10000/';
						 exec "$execbin $link";
					     }), 
			   gtksignal_connect(Gtk2::Button->new(N("Abort")), clicked => \&quit))));
$w->{window}->show_all;
$w->main;

sub quit() { ugtk2->exit(0) }
