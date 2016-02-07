#!/usr/bin/perl


use lib qw(/usr/lib/libDrakX);
use common;
# i18n : IMPORTANT to get correct namespace (drakconf instead of libDrakX)
BEGIN { unshift @::textdomains, 'drakconf' }
use ugtk3 qw(:helpers :wrappers);
use interactive;
use standalone;

sub gtkcan_default {
    $_[0]->get_can_default($_->[1]);
    $_[0];
}

my $bindir = "/usr/bin/";
my $my_win = ugtk3->new('print_launcher');
$my_win->{rwindow}->set_title(N("Menu Configuration Center")) unless $::isEmbedded;
$my_win->{window}->signal_connect(delete_event => sub {
    gtkset_mousecursor_normal();
    ugtk3->exit(0);
});
my $table = Gtk3::Table->new(3, 2, 0);
$table->set_border_width(5);
$table->set_row_spacings(5);
$table->set_col_spacings(5);
$table->attach(Gtk3::Label->new(N("System menu")), 0, 1, 0, 1, 'fill', 'fill', 0, 0);
my $b1 = gtksignal_connect(Gtk3::Button->new(N("Configure...")), clicked => sub { system("$bindir/menudrake --systemmenu &") });
$table->attach($b1, 1, 2, 0, 1, 'fill', 'fill', 0, 0);
$table->attach(Gtk3::Label->new(N("User menu")), 0, 1, 1, 2, 'fill', 'fill', 0, 0);

my $combo = Gtk3::OptionMenu->new;
$combo->set_popdown_strings("root", sort(list_users()));
$table->attach($combo, 2, 3, 1, 2, 'fill', 'fill', 0, 0);
my $b2 = gtksignal_connect(Gtk3::Button->new(N("Configure...")),
                  clicked => sub { my $a = $combo->entry->get_text(); system($a eq "root" ? "$bindir/menudrake --usermenu &" : " su $a -c \"$bindir/menudrake\" &") });
$table->attach($b2, 1, 2, 1, 2, 'fill', 'fill', 0, 0);

$my_win->{window}->add(gtkpack(Gtk3::VBox->new(0, 0),
                               Gtk3::Label->new(N("Menu Configuration Center") . N("\n\nChoose which menu you want to configure")),
                               Gtk3::HSeparator->new,
                               $table,
                               Gtk3::HSeparator->new,
                               gtkpack(gtkset_layout(Gtk3::HButtonBox->new, 'end'),
                                       gtkcan_default(gtksignal_connect(Gtk3::Button->new_from_stock('gtk-close'), clicked => sub { ugtk3->exit(0) }), 1)
                                      ),
                              ),
                      );


$my_win->{window}->show_all;
$my_win->main;
ugtk3->exit(0);
