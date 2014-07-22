#!/usr/bin/perl


use lib qw(/usr/lib/libDrakX);
use common;
# i18n : IMPORTANT to get correct namespace (drakconf instead of libDrakX)
BEGIN { unshift @::textdomains, 'drakconf' }
use ugtk2 qw(:helpers :wrappers);
use interactive;
use standalone;

sub gtkcan_default {
    $_[0]->can_default($_->[1]);
    $_[0];
}

my $bindir = "/usr/bin/";
my $my_win = ugtk2->new('print_launcher');
$my_win->{rwindow}->set_title(N("Menu Configuration Center")) unless $::isEmbedded;
$my_win->{window}->signal_connect(delete_event => sub {
    gtkset_mousecursor_normal();
    ugtk2->exit(0);
});
my $table = Gtk2::Table->new(3, 2, 0);
$table->set_border_width(5);
$table->set_row_spacings(5);
$table->set_col_spacings(5);
$table->attach(Gtk2::Label->new(N("System menu")), 0, 1, 0, 1, 'fill', 'fill', 0, 0);
my $b1 = gtksignal_connect(Gtk2::Button->new(N("Configure...")), clicked => sub { system("$bindir/menudrake --systemmenu &") });
$table->attach($b1, 1, 2, 0, 1, 'fill', 'fill', 0, 0);
$table->attach(Gtk2::Label->new(N("User menu")), 0, 1, 1, 2, 'fill', 'fill', 0, 0);

my $combo = Gtk2::OptionMenu->new;
$combo->set_popdown_strings("root", sort(list_users()));
$table->attach($combo, 2, 3, 1, 2, 'fill', 'fill', 0, 0);
my $b2 = gtksignal_connect(Gtk2::Button->new(N("Configure...")),
                  clicked => sub { my $a = $combo->entry->get_text(); system($a eq "root" ? "$bindir/menudrake --usermenu &" : " su $a -c \"$bindir/menudrake\" &") });
$table->attach($b2, 1, 2, 1, 2, 'fill', 'fill', 0, 0);

$my_win->{window}->add(gtkpack(Gtk2::VBox->new(0, 0),
                               Gtk2::Label->new(N("Menu Configuration Center") . N("\n\nChoose which menu you want to configure")),
                               Gtk2::HSeparator->new,
                               $table,
                               Gtk2::HSeparator->new,
                               gtkpack(gtkset_layout(Gtk2::HButtonBox->new, 'end'),
                                       gtkcan_default(gtksignal_connect(Gtk2::Button->new_from_stock('gtk-close'), clicked => sub { ugtk2->exit(0) }), 1)
                                      ),
                              ),
                      );


$my_win->{window}->show_all;
$my_win->main;
ugtk2->exit(0);
