#!usr/bin/perl

package Extract::TBX::Min;

use lib qw'../../../lib';
use strict;
use warnings;
use Extract::TBX::Min::BasicClass;
use XML::Twig;
use Exporter::Easy (
	OK => [ 'tbxtract' ]
	);
use open ':encoding(utf8)', ':std';

=head1 NAME

    Extract::TBX::Min - This tool serves to allow the extraction of a selected subset of TBX-Basic as a TBX-Min file.
    
=head1 SYNOPSIS

    use Extract::TBX::Min 'tbxtract';
    tbxtract('path/to/file.tbx');
    
=head1 DESCRIPTION

Extract::TBX::Min is a tool which allows you to input a valid TBX-Basic file and output a valid TBX-Min subset termbase.
This is primarily useful for terminology managers who want to send only pertinent glossary information to their bilingual
translators, rather than sending the entire TBX-Basic glossary.

Extract::TBX::Min is not a converter.  For straight conversion see Convert::TBX::Min.  As Extract::TBX::Min specializes in
extraction, it requires more user input that a straight conversion.  The user will need to choose which data-categories
to extract in addition to 1 or two languages.  TBX-Min is a monolingual or bilingual terminology exchange format and
cannot support more than two languages (a source and a target).

=head1 METHODS

=cut

sub tbxtract
{
    my $path = shift;
    
    die "File could not be found" unless (-e $path);
    
    _pre_process($path);
}

sub _pre_process
{
    my $path = shift;
    
    my $basic = new Extract::TBX::Min::BasicClass();
    
    my $twig = XML::Twig->new(
        twig_handlers => {
            langSet => sub { _read_langSet(\$basic, @_) },
            descrip => sub { _read_descrip(\$basic, @_) },
            termNote => sub { _read_termNote(\$basic, @_) }
        }
        
    );
    
    $twig->parsefile($path);

    _show_ui($basic);
}


sub _show_ui
{
    my ($basic) = @_;
    
    
}

sub _read_langSet
{
    my ($basic, $twig, $node) = @_;
    
    $$basic->add_lang($node->att('xml:lang'));
}

sub _read_descrip
{
    my ($basic, $twig, $node) = @_;
    
    $$basic->add_descrip($node->att('type'));
}

sub _read_termNote
{
    my ($basic, $twig, $node) = @_;
    
    $$basic->add_termNote($node->att('type'));
}

_run() unless caller;

=head1 TODO

=head1 SEE ALSO

=over

=item L<tbxtract>

=item L<Convert::TBX::Min>

=back
=cut

package ShowUI;

use strict;
use warnings;
use Extract::TBX::Min::UI;

sub show
{
    my $UI = Extract::TBX::Min::UI->new();
}