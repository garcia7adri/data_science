# coding: utf-8
#fourcalculations.py
"""A very simple class exercise for four arithmetic calculations"""

class FourCalculation:
    "A class for four arithmetic calculations"
    
    def __init__(self,first,second):
        """Initialize attributes of FourCalculation."""
        self.first=first
        self.second=second
        
        if second==0:
            raise ValueError("The number must NOT be zero.")
    def add(self):
            """Addition"""
            return self.first + self.second
    def mult(self):
        """Multiplication"""
        return self.first * self.second
    def sub(self):
        """Substraction"""
        return self.first - self.second
    def div(self):
        """Division"""
    
        return self.first /self.second
