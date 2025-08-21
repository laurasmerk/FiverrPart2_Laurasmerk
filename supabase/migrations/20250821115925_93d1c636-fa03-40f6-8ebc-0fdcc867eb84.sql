-- Create leads table to store lead capture data
CREATE TABLE public.leads (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT NOT NULL,
  email TEXT NOT NULL,
  industry TEXT NOT NULL,
  submitted_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

-- Enable Row Level Security
ALTER TABLE public.leads ENABLE ROW LEVEL SECURITY;

-- Create policies for anonymous lead submission
-- Allow anyone to insert leads (for anonymous lead capture)
CREATE POLICY "Anyone can submit leads" 
ON public.leads 
FOR INSERT 
TO anon, authenticated
WITH CHECK (true);

-- Restrict reading leads to authenticated users only (for admin/dashboard access)
CREATE POLICY "Authenticated users can view leads" 
ON public.leads 
FOR SELECT 
TO authenticated
USING (true);

-- Create function to update timestamps
CREATE OR REPLACE FUNCTION public.update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create trigger for automatic timestamp updates
CREATE TRIGGER update_leads_updated_at
  BEFORE UPDATE ON public.leads
  FOR EACH ROW
  EXECUTE FUNCTION public.update_updated_at_column();

-- Add indexes for better performance
CREATE INDEX idx_leads_email ON public.leads(email);
CREATE INDEX idx_leads_industry ON public.leads(industry);
CREATE INDEX idx_leads_submitted_at ON public.leads(submitted_at DESC);