package MDV::Control_Center;

# Copyright (C) 1999-2008 Mandriva
#                         Daouda Lo
#                         Damien Krotkine
#                         Thierry Vignaud <tvignaud@mandriva.com>
#                         Yves Duret
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



use lib qw(/usr/lib/libDrakX);
use common;


use Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw(
                    $mcc_dir $themes_dir
                    %programs
                    $version
            );

our ($version) = cat_("/etc/distro-release") =~ /\b(\d+\.\d+)/;


#-------------------------------------------------------------
# paths
our $mcc_dir = "/usr/share/mcc";
our $themes_dir = "$mcc_dir/themes/";


# { key => { log_exp, binary, embedded?, description ] }
# embedded meaning: -1 => not embedded, 0 => external x11 app, 1 => proper embedding
our %programs =
  (

   "Authentication" =>
   {
    binary => "drakauth",
    embedded => 1,
    description =>
    #-PO: this message is already translated in drakx domain from which MCC will searchs it:
    N("Authentication"),
    long_description => N("Select the authentication method (local, NIS, LDAP, Windows Domain, ...)"),
    icon => 'drakauth-mdk',
   },


   "Backups" =>
   {
    binary => "drakbackup",
    embedded => 1,
    description => N("Backups"),
    long_description => N("Configure backups of the system and of the users' data"),
    icon => 'backup-mdk',
    application_driven_menu => 1,
   },


   "Snapshots" =>
   {
    binary => "draksnapshot-config",
    embedded => 1,
    description => N("Snapshots"),
    long_description => '',
    icon => 'snapshots',
   },

# (tpg) hide it as it does not work like expected
#   "Boot Config" =>
#   {
#    binary => "drakboot --boot",
#    embedded => -1,
#    description => N("Set up boot system"),
#    long_description => N("Set up how the system boots"),
#    icon => 'drakboot-mdk',
#   },


   "Boot Theme" =>
   {
    binary => "drakboot --splash",
    embedded => 1,
    description => N("Set up boot graphical theme of system"),
    long_description => N("Select the graphical theme of the system while booting"),
    icon => 'boot-theme-mdk',
   },


   "Connection Sharing" =>
   {
    binary => "drakgw",
    embedded => 1,
    description => N("Share the Internet connection with other local machines"),
    long_description => N("Share the Internet connection with other local machines"),
    icon => 'drakgw-mdk',
   },


   "Add Connection" =>
   {
    binary => "drakconnect --wizard",
    embedded => 1,
    description => N("Set up a new network interface (LAN, ISDN, ADSL, ...)"),
    long_description => N("Set up a new network interface (LAN, ISDN, ADSL, ...)"),
    icon => 'new-connection-mdk',
   },


   "Configure Internet" =>
   {
    binary => "drakconnect --internet",
    embedded => 1,
    description => N("Internet access"),
    long_description => N("Alter miscellaneous internet settings"),
    icon => 'internet-access-mdk',
   },


   "Console" =>
   {
    binary => "drakconsole",
    embedded => 1,
    description => N("Open a console as administrator"),
    long_description => N("Open a console as administrator"),
    icon => 'console-mdk',
   #The Console will help you to solve issues
   },


   "Date & Time" =>
   {
    binary => "clock.pl",
    embedded => 1,
    description => N("Manage date and time"),
    long_description => N("Manage date and time"),
    icon => 'time-mdk',
   },


   "Display Manager chooser" =>
   {
    binary => "drakedm",
    embedded => 1,
    description => N("Set up display manager"),
    long_description => N("Choose the display manager that enables to select which user to log in"),
    icon => 'drakedm-mdk',
   },


   "Fax" =>
   {
    binary => "drakfax_server",
    embedded => 1,
    description => N("Configure a fax server"),
    long_description => N("Configure a fax server"),
    icon => 'drakfax-mdk',
   },


   "Firewall" =>
   {
    binary => "firewall-config",
    embedded => -1,
    description => N("Set up your personal firewall"),
    long_description => N("Set up a personal firewall in order to protect the computer and the network"),
    icon => 'firewall-mdk',
   },


   "Fonts" =>
   {
    binary => "drakfont",
    embedded => 1,
    description => N("Manage, add and remove fonts. Import Windows(TM) fonts"),
    long_description => N("Manage, add and remove fonts. Import Windows(TM) fonts"),
    icon => 'drakfont-mdk',
   },


   "Graphical server configuration" =>
   {
    binary => "XFdrake",
    embedded => 1,
    description => N("Set up the graphical server"),
    long_description => N("Set up the graphical server"),
    icon => 'XFdrake-mdk'
   },


   "Hard Drives" =>
   {
    binary => "diskdrake --hd",
    embedded => 1,
    description => N("Manage disk partitions"),
    long_description => N("Create, delete and resize hard disk partitions"),
    icon => 'diskdrake_hd',
   },


   "Hardware List" =>
   {
    binary => "harddrake2",
    embedded => 1,
    description => N("Browse and configure hardware"),
    long_description => N("Browse and configure hardware"),
    icon => 'harddrake-mdk',
    application_driven_menu => 1,
   },


   "Sound" =>
   {
    binary => "draksound",
    embedded => 1,
    description => N("Sound Configuration"),
    long_description => N("Sound Configuration"),
    icon => 'sound',
   },


   "Hosts" =>
   {
    binary => "drakhosts",
    embedded => 1,
    description => N("Hosts definitions"),
    long_description => N("Manage hosts definitions"),
    icon => 'drakhosts',
   },


   "Install Software" =>
   {
    binary => "rpmdrake",
    embedded => 1,
    description => N("Install & Remove Software"),
    long_description => N("Install, uninstall software"),
    icon => 'installremoverpm',
    application_driven_menu => 1,
   },


   "Invictus Firewall" =>
   {
    binary => "drakinvictus",
    embedded => 1,
    description => N("Advanced setup for network interfaces and firewall"),
    long_description => N("Set up network interfaces failover and firewall replication"),
    icon => 'invictus',
   },


   "Keyboard" =>
   {
    binary => "keyboarddrake",
    embedded => 1,
    description => N("Set up the keyboard layout"),
    long_description => N("Set up the keyboard layout"),
    icon => 'keyboard-mdk',
   },


   "Kolab" =>
   {
    binary => "kolab",
    embedded => 1,
    description => N("Kolab"),
    long_description => N("Set up a groupware server"),
   },


   "Localization" =>
   {
    binary => "localedrake",
    embedded => 1,
    icon => 'localedrake',
    description => N("Manage localization for your system"),
    long_description => N("Select the language and the country or region of the system"),
   },


   "Logs" =>
   {
    binary => "false",
    embedded => 1,
    description => N("View and search system logs"),
    long_description => N("View and search system logs"),
    icon => 'logdrake-mdk',
   },


   "Manage Connection" =>
   {
    binary => "drakconnect --skip-wizard",
    embedded => 1,
    description => N("Manage connections"),
    long_description => N("Reconfigure a network interface"),
    icon => 'manage-connections-mdk',
   },


   "Manage park" =>
   {
    binary => "park-rpmdrake",
    embedded => 1,
    description => N("Manage computer group"),
    long_description => N("Manage installed software packages on a group of computers"),
    icon => 'drakpark-mdk',
   },

   "OpenMandriva Tools Authentication" =>
   {
    binary => "draksec",
    embedded => 1,
    description => N("Configure authentication for OpenMandriva tools"),
    long_description => N("Define authentication required to access individual OpenMandriva configuration tools "),
    icon => 'drakperm-mdk',
   },

   "OpenMandriva Update" =>
   {
    binary => "OnlineUpdate",
    embedded => 1,
    description => N("Update your system"),
    long_description => N("Look at available updates and apply any fixes or upgrades to installed packages"),
    icon => 'MandrivaUpdate',
    application_driven_menu => 1,
   },


   "Menus" =>
   {
    binary => "drakmenustyle",
    embedded => 1,
    description => N("Menu Style"),
    long_description => N("Menu Style Configuration"),
    icon => 'drakmenustyle',
   },


   "Migration" =>
   {
    binary => "transfugdrake",
    embedded => 1,
    description => N("Import Windows(TM) documents and settings"),
    long_description => N("Import Windows(TM) documents and settings"),
    icon => 'migrationtools',
   },


   "Monitor Connection" =>
   {
    binary => "net_monitor",
    embedded => 1,
    description => N("Monitor connections"),
    long_description => N("Monitor the network connections"),
    icon => 'net_monitor-mdk',
   },


   "Mouse" =>
   {
    binary => "mousedrake",
    embedded => 1,
    description => N("Set up the pointer device (mouse, touchpad)"),
    long_description => N("Set up the pointer device (mouse, touchpad)"),
    icon => 'mousedrake-mdk',
   },


   "Parental Controls" => {
    binary => "drakguard",
    embedded => 1,
    description => N("Parental Controls"),
    long_description => N("Parental Controls"),
    icon => 'drakguard',
   },


   "Network Center" =>
   {
    binary => "draknetcenter",
    embedded => 1,
    description => N("Network Center"),
    long_description => N("Manage your network devices"),
    icon => 'netcenter',
   },


   "Network Profiles" =>
   {
    binary => "draknetprofile",
    embedded => 1,
    description => N("Manage different network profiles"),
    long_description => N("Activate and manage network profiles"),
    icon => 'draknetprofile',
   },


   "NFS mount points" =>
   {
    binary => "diskdrake --nfs",
    embedded => 1,
    description => N("Access NFS shared drives and directories"),
    long_description => N("Set NFS mount points"),
    icon => 'diskdrake_nfs',
   },


   "NFS exports" =>
   {
    binary => "draknfs",
    embedded => 1,
    description => N("Share drives and directories using NFS"),
    long_description => N("Manage NFS shares"),
    icon => 'draknfs',
    application_driven_menu => 1,
   },


   "Package stats" =>
   {
    binary => "drakstats",
    embedded => 1,
    description => N("Package Stats"),
    long_description => N("Show statistics about usage of installed software packages"),
    icon => 'source-manager',
   },


   "Partition Sharing" =>
   {
    binary => "diskdrake --fileshare",
    embedded => 1,
    description => N("Share your hard disk partitions"),
    long_description => N("Set up sharing of your hard disk partitions"),
    icon => 'diskdrake_fileshare',
   },


   "Printer" =>
   {
    binary => "system-config-printer",
    embedded => -1,
    description => N("Set up the printer(s), the print job queues, ..."),
    icon => 'printer-mcc-mdk',
    long_description => N("Set up the printer(s), the print job queues, ..."),
    services_to_start_after_install => [ 'cups' ],
    application_driven_menu => 1,
   },
 

   "Programs scheduling" =>
   {
    binary => "drakcronat",
    embedded => 1,
    description => N("Scheduled tasks"),
    long_description => N("Schedule programs to run periodically or at given times"),
    #DrakCronAt enables to schedule Programs execution through crond and atd daemons
    icon => 'drakcronat-mdk',
   },

   "Proxy Configuration" =>
   {
    binary => "drakproxy",
    embedded => 1,
    description => N("Proxy"),
    long_description => N("Set up a proxy server for files and web browsing"),
    icon => 'drakproxy-mdk',
   },

   "Remote Control" =>
   {
    binary => "rfbdrake",
    embedded => 1,
    description => N("Remote Control (Linux/Unix, Windows)"),
    long_description => N("Remote Control of another machine (Linux/Unix, Windows)"),
    icon => 'internet-access-mdk',
   },


   "Remove Interface" =>
   {
    binary => "drakconnect --del",
    embedded => 1,
    description => N("Remove a connection"),
    long_description => N("Delete a network interface"),
    icon => 'remove-connection-mdk',
   },


   #- currently unused
   "Roaming" =>
   {
    binary => "drakroam",
    embedded => 1,
    description => N("Wireless connection"),
    long_description => N("Wireless connection"),
    icon => 'drakroam-mdk',
   },


   "Access Windows shares" =>
   {
    binary => "diskdrake --smb",
    embedded => 1,
    description => N("Access Windows (SMB) shared drives and directories"),
    long_description => N("Configuration of Windows (Samba) shared drives and directories"),
    icon => 'diskdrake_samba',
   },


   "Samba configuration" =>
   {
    binary => "draksambashare",
    embedded => 1,
    description => N("Share drives and directories with Windows (SMB) systems"),
    long_description => N("Manage configuration of Samba"),
    icon => 'draksambashare',
    application_driven_menu => 1,
   },

   "Scanner" =>
   {
    binary => "scannerdrake",
    embedded => 1,
    description => N("Set up scanner"),
    long_description => N("Set up scanner"),
    icon => 'scanner-mdk',
   },


   "Security Level" =>
   {
    binary => "msecgui",
    embedded => 1,
    description => N("Configure system security, permissions and audit"),
    long_description => N("Set the system security level, periodic security audit and permissions"),
    icon => 'draksec-mdk',
    application_driven_menu => 1,
   },


   "Services" =>
   {
    binary => "drakxservices",
    embedded => 1,
    description => N("Manage system services by enabling or disabling them"),
    long_description => N("Manage system services by enabling or disabling them"),
    icon => 'service-mdk',
   },


   "Software Media Manager" =>
   {
    binary => "edit-urpm-sources.pl",
    embedded => 1,
    description => N("Configure media sources for install and update"),
    long_description => N("Select from where software packages are downloaded "),
    icon => 'rpmdrake-mdk',
    application_driven_menu => 1,
   },


   "Updates Configuration" =>
   {
    binary => "mdkapplet-config",
    embedded => 1,
    description => N("Configure updates frequency"),
    icon => 'rpmdrake-mdk',
   },


   "Tomoyo Policy" =>
   {
    binary => "tomoyo-gui",
    embedded => 1,
    description => N("Configure TOMOYO Linux policy"),
    long_description => N("View and configure TOMOYO Linux security policy"),
    icon => 'draksec-mdk',
    application_driven_menu => 1,
   },


   "UPS" =>
   {
    binary => "drakups --wizard",
    embedded => 1,
    description =>
      #-PO: UPS==Uninterruptible power supply
      N("Set up a UPS for power monitoring"),
    long_description =>
    #-PO: here power means electrical power
    N("Set up a UPS for power monitoring"),
    icon => 'drakups-mdk',
   },


   "Users" =>
   {
    # too big
    binary => "userdrake",
    embedded => 1,
    description => N("Manage users on system"),
    long_description => N("Add, remove or change users of the system"),
    icon => 'user-mdk',
    application_driven_menu => 1,
   },


   "Virtualization" =>
   {
    binary => "drakvirt",
    embedded => 1,
    description => N("Virtualization"),
    long_description => N("Virtual machines management"),
    icon => 'drakvirt',
   },


   "VPN" =>
   {
    binary => "drakvpn",
    embedded => 1,
    description => N("Configure VPN connection to secure network access"),
    long_description => N("Configure VPN connection to secure network access"),
    icon => 'drakvpn',
   },


   "WebDAV mount points" =>
   {
    binary => "diskdrake --dav",
    embedded => 1,
    description => N("Access WebDAV shared drives and directories"),
    long_description => N("Set WebDAV mount points"),
    icon => 'webdav-mdk',
   },

  );




1;
