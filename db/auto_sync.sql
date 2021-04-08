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

#DELETE smart_gate_bmi on dup
CREATE  TABLE  IF NOT EXISTS smart_gate_bmi_dup  (`id` int(11) DEFAULT NULL);

TRUNCATE smart_gate_bmi_dup;

INSERT INTO smart_gate_bmi_dup SELECT id from smart_gate_bmi  WHERE vn = '0' AND  date(d_update) = CURRENT_DATE  AND cid  in (
SELECT cid from (
SELECT t.cid,COUNT(*) total  FROM smart_gate_bmi t
WHERE date(t.d_update) = CURRENT_DATE
GROUP BY t.cid  HAVING total > 1
) t );

DELETE from smart_gate_bmi WHERE id in (
SELECT id from smart_gate_bmi_dup
 );
# END DELETE


#DELETE smart_gate_bp on dup
CREATE  TABLE  IF NOT EXISTS smart_gate_bp_dup (`id` int(11) DEFAULT NULL);

TRUNCATE smart_gate_bp_dup;

INSERT INTO smart_gate_bp_dup SELECT id from smart_gate_bp  WHERE vn = '0' AND  date(d_update) = CURRENT_DATE  AND cid  in (
SELECT cid from (
SELECT t.cid,COUNT(*) total  FROM smart_gate_bp t
WHERE date(t.d_update) = CURRENT_DATE
GROUP BY t.cid  HAVING total > 1
) t );

DELETE from smart_gate_bp WHERE id in (
SELECT id from smart_gate_bp_dup
 );
# END DELETE

#DELETE smart_gate_tp on dup
CREATE  TABLE  IF NOT EXISTS smart_gate_tp_dup (`id` int(11) DEFAULT NULL);

TRUNCATE smart_gate_tp_dup;

INSERT INTO smart_gate_tp_dup SELECT id from smart_gate_tp  WHERE vn = '0' AND  date(d_update) = CURRENT_DATE  AND cid  in (
SELECT cid from (
SELECT t.cid,COUNT(*) total  FROM smart_gate_tp t
WHERE date(t.d_update) = CURRENT_DATE
GROUP BY t.cid  HAVING total > 1
) t );

DELETE from smart_gate_tp WHERE id in (
SELECT id from smart_gate_tp_dup
 );
# END DELETE


