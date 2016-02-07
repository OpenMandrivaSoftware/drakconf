#!/usr/bin/perl -w


use lib qw(/usr/lib/libDrakX);
use common;
# i18n : IMPORTANT to get correct namespace (drakconf instead of libDrakX)
BEGIN { unshift @::textdomains, 'drakconf' }
use ugtk3 qw(:helpers :wrappers);;
use interactive;
use standalone;

my $sbindir = "/usr/sbin/";
my $my_win = ugtk3->new('print_launcher');
$my_win->{rwindow}->set_title(N("Printing configuration")) unless $::isEmbedded;
$my_win->{rwindow}->signal_connect(delete_event => sub {
    gtkset_mousecursor_normal();
    ugtk3->exit(0);
  });
my $vbox = Gtk3::VBox->new(0, 0);
$my_win->{window}->add($vbox);
$vbox->pack_start(Gtk3::Label->new(N("Printing configuration")), 0, 0, 5);
$vbox->pack_start(Gtk3::HSeparator->new, 0, 0, 5);
my $table = Gtk3::Table->new(2, 1, 0);
$table->set_border_width(5);
$table->set_row_spacings(5);
$table->set_col_spacings(5);
my $hbox = Gtk3::HBox->new(0, 0);
$vbox->pack_start($hbox, 1, 1, 1);
$hbox->pack_start($table, 0, 0, 5);
$table->attach(Gtk3::Label->new(N("Click here to configure the printing system")), 0, 1, 0, 1, 'fill', 'fill', 0, 0);
my $b1 = gtksignal_connect(Gtk3::Button->new(N("Configure...")), clicked => sub { system("$sbindir/printerdrake &") });
$table->attach($b1, 1, 2, 0, 1, 'fill', 'fill', 0, 0);
$vbox->pack_start(Gtk3::HSeparator->new, 0, 0, 5);
my $bbox = Gtk3::HButtonBox->new;
$vbox->pack_start($bbox, 0, 0, 5);
$bbox->set_layout('end');
my $button_ok = gtksignal_connect(Gtk3::Button->new(N("Done")), clicked => sub { ugtk3->exit(0) });
$button_ok->can_default(1);
$bbox->add($button_ok);

$my_win->{window}->show_all;
$my_win->main;
ugtk3->exit(0);
