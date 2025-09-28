import { useState } from 'react'
import type { MouseEvent } from 'react'
import { IconButton, Menu, MenuItem } from '@mui/material'
import MenuIcon from '@mui/icons-material/Menu'
import { useNavigate } from 'react-router-dom'

interface Props {
  inspectionId: number
  status?: string
}

export default function InspectionActionsMenu({ inspectionId, status }: Props) {
  const navigate = useNavigate()
  const [anchorEl, setAnchorEl] = useState<null | HTMLElement>(null)

  const open = Boolean(anchorEl)
  const handleOpen = (event: MouseEvent<HTMLElement>) => {
    setAnchorEl(event.currentTarget)
  }
  const handleClose = () => setAnchorEl(null)

  const goToForm = () => {
    handleClose()
    navigate(`/inspections/${inspectionId}/form`)
  }

  const handleQrDownload = () => {
    handleClose()
    // TODO: Implement QR code download flow
  }

  const showStart = status === 'not_started'
  const startLabel = showStart ? 'Muayeneyi Başlat' : 'Muayeneye Devam Et'

  return (
    <>
      <IconButton size="small" onClick={handleOpen} aria-haspopup="true" aria-controls={`inspection-menu-${inspectionId}`} aria-label="Muayene işlemleri">
        <MenuIcon fontSize="small" />
      </IconButton>
      <Menu
        id={`inspection-menu-${inspectionId}`}
        anchorEl={anchorEl}
        open={open}
        onClose={handleClose}
        anchorOrigin={{ vertical: 'bottom', horizontal: 'left' }}
        transformOrigin={{ vertical: 'top', horizontal: 'left' }}
        MenuListProps={{ dense: true }}
        PaperProps={{
          sx: {
            minWidth: 160,
            mt: 0.5,
            '& .MuiMenuItem-root': {
              fontSize: '0.82rem',
              py: 0.5,
            },
          },
          elevation: 3,
        }}
      >
        <MenuItem onClick={goToForm}>{startLabel}</MenuItem>
        <MenuItem onClick={handleQrDownload}>Karekod İndir</MenuItem>
      </Menu>
    </>
  )
}
