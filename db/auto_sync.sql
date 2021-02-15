
UPDATE smart_gate_bp t set t.vn = '0' WHERE t.vn = '000000000000';
UPDATE opdscreen o ,(
SELECT o.vn,t.hn,t.bps,t.bpd,t.pulse from smart_gate_bp t 
LEFT JOIN ovst o on o.hn = t.hn AND o.vstdate = date(t.d_update)
WHERE LENGTH(t.vn) <> 12 and LENGTH(t.cid) = 13 and LENGTH(t.hn)>0 ) a
set o.bps = a.bps , o.bpd = a.bpd , o.pulse = a.pulse
WHERE o.vn = a.vn;


UPDATE smart_gate_tp t set t.vn = '0' WHERE t.vn = '000000000000';
UPDATE opdscreen o ,(
SELECT o.vn,t.hn,t.tp from smart_gate_tp t 
LEFT JOIN ovst o on o.hn = t.hn AND o.vstdate = date(t.d_update)
WHERE LENGTH(t.vn) <> 12 and LENGTH(t.cid) = 13 and LENGTH(t.hn)>0 ) a
set o.temperature = a.tp
WHERE o.vn = a.vn;


UPDATE smart_gate_bmi t set t.vn = '0' WHERE t.vn = '000000000000';
UPDATE opdscreen o ,(
SELECT o.vn,t.hn,t.bw,t.bh,t.bmi from smart_gate_bmi t 
LEFT JOIN ovst o on o.hn = t.hn AND o.vstdate = date(t.d_update)
WHERE LENGTH(t.vn) <> 12 and LENGTH(t.cid) = 13 and LENGTH(t.hn)>0 ) a
set o.bw = a.bw , o.height = a.bh , o.bmi = a.bmi
WHERE o.vn = a.vn;