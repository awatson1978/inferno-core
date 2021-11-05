import { Theme } from '@mui/material/styles';

import makeStyles from '@mui/styles/makeStyles';

export default makeStyles((theme: Theme) => ({
  header: {
    color: theme.palette.primary.main,
    height: '4em',
    padding: '0.25em 0.25em',
    display: 'flex',
    alignItems: 'center',
    backgroundColor: theme.palette.common.white,
  },
  logo: {
    objectFit: 'contain',
    height: '3.5em',
  },
}));
