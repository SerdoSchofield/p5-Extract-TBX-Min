#!usr/bin/perl

package Extract::TBX::Min::BasicClass;
use strict;
use warnings;

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
    
    if ( !_in_array( $self->{languages}, $lang ) )
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
    
    if ( !_in_array( $self->{descrips}, $descrip ))
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
    
    if ( !_in_array( $self->{termNotes}, $termNote) )
    {
        push( @{$self->{termNotes}}, $termNote );
    }
}

sub get_termNotes
{
    my ($self) = @_;
    
    return $self->{termNotes};
}

sub _in_array
{
    my ($array_ref, $value) = @_;
    
    my $ret = 0;
    
    foreach (@$array_ref)
    {
        if ( lc($value) eq lc($_) )
        {
            $ret = 1;
            last;
        }
    }
    
    return $ret;
}

1;