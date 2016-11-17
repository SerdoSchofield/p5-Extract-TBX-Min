#!usr/bin/perl

package Extract::TBX::Min;

use lib qw'../../../lib';
use strict;
use warnings;
use Extract::TBX::Min::BasicClass;
use Extract::TBX::Min::Methods qw(in_array get_user_input splice_by_val);
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
    my %langs = ( 'source', 'target' );
    my $prompt = "Do you want to extract a monolingual or bilingual termbase [mono/bi]: ";
    my $err_prompt = "Please only respond with the allowed values [mono/bi]: ";
    my @allowed_vals = ('mono', 'bi');
    my $response = get_user_input($prompt, $err_prompt, \@allowed_vals); 
    my $isBilingual = (lc($response) eq 'mono') ? 0 : 1;
    
    #Choose Source
    $prompt = "Please select the source language [@{$basic->get_langs()}]: ";
    $err_prompt = "Please only choose from the list [@{$basic->get_langs()}]: ";
    $langs{'source'} = get_user_input($prompt, $err_prompt, $basic->get_langs());
    
    #If bilingual, choose Target
    unless(!$isBilingual)
    {
        my $edited_langs = splice_by_val($basic->get_langs(), $langs{'source'});
        $prompt = "Please select the target language [@{$edited_langs}]: ";
        $err_prompt = "Please only choose from the list [@{$edited_langs}]: ";
        $langs{'target'} = get_user_input($prompt, $err_prompt, $edited_langs);
    }
    
    
    
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