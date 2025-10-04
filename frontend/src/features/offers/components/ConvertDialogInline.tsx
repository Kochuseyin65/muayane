import { Dialog, DialogActions, DialogContent, DialogTitle, Stack, TextField, Button } from '@mui/material'
import { useEffect, useState } from 'react'

export default function ConvertDialogInline({ open, onClose, onSave }: { open: boolean; onClose: () => void; onSave: (payload: { openingDate?: string; taskStartDate?: string; taskEndDate?: string; notes?: string }) => void }) {
  const today = new Date().toISOString().slice(0, 10)
  const [openingDate, setOpeningDate] = useState<string>(today)
  const [taskStartDate, setTaskStartDate] = useState<string>('')
  const [taskEndDate, setTaskEndDate] = useState<string>('')
  const [notes, setNotes] = useState<string>('')

  useEffect(() => {
    if (open) {
      setOpeningDate(today)
      setTaskStartDate('')
      setTaskEndDate('')
      setNotes('')
    }
  }, [open])

  const submit = () => onSave({
    openingDate: openingDate || undefined,
    taskStartDate: taskStartDate || undefined,
    taskEndDate: taskEndDate || undefined,
    notes: notes || undefined
  })
  return (
    <Dialog open={open} onClose={onClose} fullWidth maxWidth="sm">
      <DialogTitle>İş Emrine Dönüştür</DialogTitle>
      <DialogContent>
        <Stack spacing={2} sx={{ mt: 1 }}>
          <TextField type="date" label="Açılış Tarihi" InputLabelProps={{ shrink: true }} value={openingDate} onChange={(e) => setOpeningDate(e.target.value)} />
          <TextField type="date" label="Görev Başlangıç Tarihi" InputLabelProps={{ shrink: true }} value={taskStartDate} onChange={(e) => setTaskStartDate(e.target.value)} />
          <TextField type="date" label="Görev Bitiş Tarihi" InputLabelProps={{ shrink: true }} value={taskEndDate} onChange={(e) => setTaskEndDate(e.target.value)} />
          <TextField label="Notlar" value={notes} onChange={(e) => setNotes(e.target.value)} multiline minRows={3} />
        </Stack>
      </DialogContent>
      <DialogActions>
        <Button onClick={onClose}>İptal</Button>
        <Button variant="contained" onClick={submit}>Dönüştür</Button>
      </DialogActions>
    </Dialog>
  )
}
