#!usr/bin/perl

use lib qw'../../../../lib';
package Extract::TBX::Min::BasicClass;
use strict;
use warnings;
use Extract::TBX::Min::Methods 'in_array';

sub _init
{
    my $self = shift;
    
    $self->{descrips} = [];
    $self->{languages} = [];
    $self->{termNotes} = [];
}

sub new
{
    my $class = shift;
    my $self = {};
    bless $self, $class;
    
    $self->_init();
    return $self;
}

sub add_lang
{
    my ($self, $lang) = @_;
    
    if ( !in_array( $self->{languages}, $lang ) )
    {
        push( @{$self->{languages}}, $lang );
    }
}

sub get_langs
{
    my ($self) = @_;
    
    return $self->{languages};
}

sub add_descrip
{
    my ($self, $descrip) = @_;
    
    if ( !in_array( $self->{descrips}, $descrip ))
    {
        push( @{$self->{descrips}}, $descrip );
    }
}

sub get_descrips
{
    my ($self) = @_;
    
    return $self->{descrips};
}

sub add_termNote
{
    my ($self, $termNote) = @_;
    
    if ( !in_array( $self->{termNotes}, $termNote) )
    {
        push( @{$self->{termNotes}}, $termNote );
    }
}

sub get_termNotes
{
    my ($self) = @_;
    
    return $self->{termNotes};
}

1;